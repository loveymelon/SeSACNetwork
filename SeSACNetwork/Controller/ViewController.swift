//
//  ViewController.swift
//  SeSACNetwork
//
//  Created by 김진수 on 1/16/24.
//

import UIKit
import Alamofire

/*
 {
     "message": {
         "@type": "response",
         "@service": "naverservice.nmt.proxy",
         "@version": "1.0.0",
         "result": {
             "srcLangType": "ko",
             "tarLangType": "en",
             "translatedText": "Hello",
             "engineType": "PRETRANS"
         }
     }
 }
 */

struct Papago: Codable {
    let message: PapagoResult
}

struct PapagoResult: Codable {
    let result: PapagoFinal
}

struct PapagoFinal: Codable {
    let srcLangType: String
    let tarLangType: String
    let translatedText: String
    let engineType: String
}

class ViewController: UIViewController {
    
    @IBOutlet var sourceTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    @IBOutlet var targetLabel: UILabel!
    @IBOutlet var originButton: UIButton!
    @IBOutlet var changeButton: UIButton!
    @IBOutlet var purposeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designButton()
        self.translateButton.addTarget(self, action: #selector(translateButtonClicked), for: .touchUpInside)
        self.originButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        self.purposeButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
    }
    /*
     1. 네트워크 통신 단절 상태
     2. API 콜수가 다 찰때
     3. 번역 버튼을 연속 클릭을 방지( 지금 로직에서는 버튼을 누를때마다 통신을 하기 때문에 그렇게 되면 콜수가 금방 다 차게 된다.)
     4. 텍스트 비교 (바로 직전에 번역한 텍스트라면 비용을 발생시키면서 바로 또 번역을 할 필요가 없다.)
     5. LoadingView
     */
    @objc func translateButtonClicked() {
        let url = "https://openapi.naver.com/v1/papago/n2mt"
        
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.clientID,
            "X-Naver-Client-Secret": APIKey.clientSecret
        ]
        //
        let parameters: Parameters = [
            "text": self.sourceTextView.text!,
            "source": "ko",
            "target": "en"
        ]
        
        AF.request(url, method: .post, parameters: parameters, headers: headers).responseDecodable(of: Papago.self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                
                self.targetLabel.text = success.message.result.translatedText
            case .failure(let failure):
                print(failure)
            }
        }
        
    } // Action연결과 addtarget 차이점
    
    @objc func tappedButton() {
        let vc = storyboard?.instantiateViewController(identifier: "LanguageViewController") as! LanguageViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController {
    func designButton() {
        self.originButton.setTitle("한국어", for: .normal)
        self.purposeButton.setTitle("영어", for: .normal)
        self.changeButton.setTitle("", for: .normal)
        
        self.changeButton.setImage(UIImage(systemName: "fibrechannel"), for: .normal)
    }
}
