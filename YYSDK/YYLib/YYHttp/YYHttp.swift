//
//  YYHttp.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/9/29.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import Alamofire

enum YYHttpMethod: String {
    case get = "GET"
    case post = "POST"
}

class YYHttp {
    class func request(method: YYHttpMethod = .get, urlString: String, parameters: [String : String]? = nil, headers: [String : String]? = nil, completion: @escaping (_ request: Any) -> Void) {
        
        Alamofire
            .request(urlString, method: .get, parameters: parameters, headers: headers)
            .responseJSON { response in
            
            guard let result = response.result.value else {
                print(response.result.error)
                return
            }
            
            completion(result: result)
        }
        
        
    }
}





















