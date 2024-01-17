//
//  LottoAPIManager.swift
//  SeSACNetwork
//
//  Created by 김진수 on 1/16/24.
//

import Foundation
import Alamofire

struct LottoAPIManager {
    
    func callRequest(number: Int,  completionHandler: @escaping (String) -> Void) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(number)"
        
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let success):
                print(success)
                print(success.drwNoDate)
                print(success.drwtNo1)
                
//                self.dateLabel.text = success.drwNoDate
                completionHandler(success.drwNoDate)
                
            case .failure(let failure):
                print("오류 발생") // 와이파이 연결 실패, 데이터가 없어 연결이 안되는 등 어떤 문제로 네트워크 연결이 안될때
            }
        }
    }
    
}
