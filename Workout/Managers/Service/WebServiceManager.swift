//
//  WebServiceManager.swift
//  Workout
//
//  Created by NTQ on 8/13/18.
//  Copyright © 2018 NTQ. All rights reserved.
//

import Foundation
import Alamofire

class WebServiceManager : NSObject{

    var parameters = Parameters()
    var headers = HTTPHeaders()
    var method: HTTPMethod = .post
    var baseUrl: String {
        guard let proto = InfoPlistKey.apiProtocol.value, let urlString = InfoPlistKey.baseAPIUrl.value, urlString.count > 0 else {
            fatalError("Need setup key: '\(InfoPlistKey.baseAPIUrl.rawValue)' in .xcconfig file")
        }
        return proto + "://" + urlString
    }
    
    var encoding: ParameterEncoding?
    
    private(set) var url: String = ""
    
    init(params: [String: Any]? = nil, headers: [String: String] = [:], endPointUrl: String = "", method: HTTPMethod = .post, encoding: ParameterEncoding? = JSONEncoding.default){
        super.init()

        params?.forEach{parameters.updateValue($0.value, forKey: $0.key)}
        headers.forEach({self.headers.add(name: $0.key, value: $0.value)})
        
        if let accessTk = AppCenter.shared.userSession.accessToken() {
            self.headers.add(name: APIKey.authorization, value: "Bearer \(accessTk)")
        }
        
        if let abbreviation =  TimeZone.current.abbreviation() {
            self.headers.add(name: APIKey.timezone, value: abbreviation)
        }
        
        self.headers.add(name: APIKey.content_Type, value: "application/json")
        self.encoding = encoding
        
        if !endPointUrl.isEmpty {
            self.url += "\(baseUrl)/\(endPointUrl)"
        }

        self.method = method
        print("url request: \(url) \n params: \(parameters)")
    }
    
    func executeQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        AF.request(url,method: method, parameters: parameters,encoding: encoding ?? JSONEncoding.default, headers: headers).responseData(completionHandler: {response in
            switch response.result{
            case .success(let res):
                if let code = response.response?.statusCode {
                    switch code {
                    case 200...1000:
                        
                        if code == APIStatusCode.success.rawValue, let json = self.convertDataToJSon(data: res) {
                            print(json)
                        } else if code == APIStatusCode.invalidToken.rawValue {
                            AppCenter.shared.userSession.logout()
                        }
                    
                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: res)))
                        } catch let error {
                            print(String(data: res, encoding: .utf8) ?? "nothing received")
                            completion(.failure(error))
                        }
                    default:
                        let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        completion(.failure(ServiceError(error)))
                    }
                }
            case .failure(let error):
                completion(.failure(ServiceError(error)))
            }
        })
    }
    
    private func convertDataToJSon(data: Data) -> [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            return json
        } catch {
            return nil
        }
        
    }
    
    static func logout() {
        let service = WebServiceManager(endPointUrl: APIPath.logout, method: .post, encoding: JSONEncoding.default)
        ProgressHUD.show()
        service.executeQuery { (result: Result<APIParser<EmptyEntity>,Error>)  in
            ProgressHUD.hide()
            AppCenter.shared.mainFrame.makeMainScreenAuthorization(window: appDelegate().window ?? UIWindow())
        }
    }
}
