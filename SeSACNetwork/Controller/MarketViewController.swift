//
//  MarketViewController.swift
//  SeSACNetwork
//
//  Created by 김진수 on 1/16/24.
//

import UIKit
import Alamofire

class MarketViewController: UIViewController {
    
    struct Market: Decodable {
        let market: String
        let korean_name: String
        let english_name: String
    }
    
    var list: [Market] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        configureTableView()
    }
    
}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath)
        let data = list[indexPath.row]
        cell.textLabel?.text = data.korean_name
        cell.detailTextLabel?.text = data.english_name
        return cell
    }
}

extension MarketViewController {
    func configureTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func callRequest() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url, method: .get).validate(statusCode: 200..<300).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let success) :
                
                if response.response?.statusCode == 200 {
                    self.list = success
                } else if response.response?.statusCode == 500 {
                    
                    print("오류가 발생했어요. 잠시 후 다시 시도해주세요.")
                    
                }
                
                self.list = success
            case .failure(let error) :
                print("error")
            }
        }
    }
}
