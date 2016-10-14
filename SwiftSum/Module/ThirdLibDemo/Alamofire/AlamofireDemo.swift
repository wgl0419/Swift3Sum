//
//  AlamofireDemo.swift
//  SwiftSum
//
//  Created by yangyuan on 2016/10/5.
//  Copyright © 2016年 huan. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireDemo: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - 处理 GET 请求的响应
    func get() {
        let url = "https://httpbin.org/get"
        Alamofire
            .request(url, method: .get, parameters: ["foo": "bar"], headers: nil)
            .responseString { response in
                print("Response String: \(response.result.value)")
            }
            .responseJSON { (response) in
                print(response.request) // 请求对象
                print(response.response)// 响应对象
                print(response.data)    // 服务端返回的数据
                
                if let json = response.result.value {
                    print(json)
                }
        }
    }
    
    // MARK: - 上传文件
    func upload() {
        let url = "https://httpbin.org/post"
        let fileUrl = Bundle.main.url(forResource: "xx", withExtension: "png")!
        Alamofire
            .upload(fileUrl, to: url, method: .post, headers: nil)
            .uploadProgress { (progress) in
                //检测上传文件进度
                print(progress.totalUnitCount)
            }
            .responseJSON { (response) in
                debugPrint(response)
        }
        
        // MARK: - 上传 MultipartFormData 类型的数据
        Alamofire
            .upload(
                multipartFormData: { (multipartFormData) in
                    multipartFormData.append(fileUrl, withName: "unicorn")
                    multipartFormData.append(fileUrl, withName: "rainbow")
                },
                to: url,
                method: .post,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { (response) in
                            debugPrint(response)
                        }
                    case .failure(let encodingError):
                        print(encodingError)
                    }
                }
        )
    }
    
    // MARK: - 下载文件
    func download() {
        let url = "https://httpbin.org/stream/100"
        _ = Alamofire
        .download(url, method: .get, parameters: nil, headers: nil) { (temporaryUrl, response) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
            let fileManager = FileManager.default
            let directoryUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            let pathComponent = response.suggestedFilename
            let url = directoryUrl?.appendingPathComponent(pathComponent!)
            return (destinationURL: url!, options: [])
        }
        
        Alamofire.download(url).downloadProgress { (progress) in
            
        }
    }
    
    // MARK: - HTTP 验证
    func authenticate() {
        let user = "user"
        let password = "password"
        let url = "https://httpbin.org/basic-auth/\(user)/\(password)"
        Alamofire.request(url, method: .get)
        .authenticate(user: user, password: password)
    }
    
    // MARK: - HTTP 响应状态信息识别
    func validate() {
        /*
         Alamofire 还提供了 HTTP 响应状态的判断识别，通过 validate 方法，对于在我们期望之外的 HTTP 响应状态信息，Alamofire 会提供报错信息：
         */
        let url = "https://httpbin.org/get"
        Alamofire.request(url, method: .get, parameters: ["foo": "bar"])
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .response { (response) in
            print(response)
        }
        
        /*
         validate 方法还提供自动识别机制，我们调用 validate 方法时不传入任何参数，则会自动认为 200…299 的状态吗为正常：
         */
        Alamofire.request(url, method: .get, parameters: ["foo": "bar"])
            .validate()
            .response { (response) in
                print(response)
        }
    }
    
    // MARK: - 调试状态
    func debug() {
        /*我们通过使用 debugPrint 函数，可以打印出请求的详细信息，这样对我们调试非常的方便：*/
        let url = "https://httpbin.org/get"
        let request = Alamofire.request(url)
        debugPrint(request)
        /*
         这样就会产生如下输出：
         
         $ curl -i \
         -H "User-Agent: Alamofire" \
         -H "Accept-Encoding: Accept-Encoding: gzip;q=1.0,compress;q=0.5" \
         -H "Accept-Language: en;q=1.0,fr;q=0.9,de;q=0.8,zh-Hans;q=0.7,zh-Hant;q=0.6,ja;q=0.5" \
         "https://httpbin.org/get?foo=bar"
         */
    }
}






























