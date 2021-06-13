//
//  AlamofireManager.swift
//  ios-network-module
//
//  Created by Abhishek on 12/06/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    public static let shared = NetworkManager()
    
    private let session: Session = {
        let configration = URLSessionConfiguration.af.default
        configration.timeoutIntervalForRequest = 30
        
        return Session(configuration: configration, interceptor: NetworkRequestInterceptor(), eventMonitors: [NetworkEventMonitor(RequestLogger.shared)])
    }()
    
    init() {
        NetworkReachability.startNetworkMonitoring()
    }

}

extension NetworkManager: ApiManagerProtocol {
    func request<T: Codable>(_ api: ApiRequestContract, onCompletion: @escaping(Result<T, Error>) -> Void) {
        session
            .request(api.path, method: api.verb.inHttpMethod(), parameters: api.getParametersEncoded(), encoding: JSONEncoding.default, headers: api.getHeaders())
            .validate()
            .responseDecodable(of: T.self) { (data) in
                guard let response = data.value else {
                    let errorText = data.error?.errorDescription
                    onCompletion(.failure(NetworkError.network(errorText)))
                    return
                }
                onCompletion(.success(response))
            }
        
    }
}
