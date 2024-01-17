//
//  LottoViewController.swift
//  SeSACNetwork
//
//  Created by 김진수 on 1/16/24.
//

import UIKit

struct Lotto: Codable {
    let drwNo: Int // 회차
    let drwNoDate: String // 날짜
    let drwtNo1: Int
    let drwtNo2: Int
    let drwtNo3: Int
    let drwtNo4: Int
    let drwtNo5: Int
    let drwtNo6: Int
    let bnusNo: Int
}

class LottoViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var numberTextField: UITextField!
    
    let manager = LottoAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager.callRequest(number: 1102) { value in
            self.dateLabel.text = value
        }
    }
    

    
    @IBAction func textFieldReturnTapped(_ sender: UITextField) {
        guard let number = Int(sender.text!) else {
            return
        }
        // 공백이거나 text일때는 안됨
        manager.callRequest(number: number) { value in
            self.dateLabel.text = value
        }
    }
}
