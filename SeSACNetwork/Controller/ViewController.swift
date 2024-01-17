//
//  ViewController.swift
//  SeSACNetwork
//
//  Created by 김진수 on 1/16/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
    }

    @objc func translateButtonClicked() {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": "LIWV9A42tCmsJ6RxsKrO",
            "X-Naver-Client-Secret": "WFs6365KNB"
        ]
        //
        let parameters: Parameters = [
            "text": self.sourceTextView.text!,
            "source": "ko",
            "target": "en"
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers)
        
    } // Action연결과 addtarget 차이점

}

