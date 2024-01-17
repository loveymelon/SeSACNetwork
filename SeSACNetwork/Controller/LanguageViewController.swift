//
//  LanguageViewController.swift
//  SeSACNetwork
//
//  Created by 김진수 on 1/17/24.
//

import UIKit

struct LanguageCode {
    static let languageCode = ["ko": "한국어", "en": "영어", "ja": "일본어", "zh-CN": "중국어 간체", "zh-TW": "중국어 번체", "vi": "베트남어", "id": "인도네시아어", "th": "태국어", "de": "독일어", "ru": "러시아어", "es": "스페인어", "it": "이탈리아어", "fr": "프랑스어"]
}

class LanguageViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    let languageKeys = LanguageCode.languageCode.keys.sorted()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }

}

extension LanguageViewController {
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension LanguageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LanguageCode.languageCode.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageCell")!
        
        cell.textLabel!.text = LanguageCode.languageCode[self.languageKeys[indexPath.row]]
        
        return cell
    }
    
    
}
