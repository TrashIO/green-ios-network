//
//  NetworkEventMonitor.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import Foundation
import Alamofire

class NetworkEventMonitor: EventMonitor {
    
    let queue = DispatchQueue(label: "co.in.greensyntax.ios-network-module")
    let logger: RequestLogger!
    var tempLog: ApiLogRequestModel?
    
    init(_ logger: RequestLogger) {
        self.logger = logger
    }
    
    func requestDidFinish(_ request: Request) {
        print("\n\n \(request.cURLDescription())")
        
        // TODO: Can implmemt this using Builder Pattern
        tempLog = ApiLogRequestModel(timeStamp: Date(), endpoint: request.request?.url?.absoluteString ?? String())
        tempLog?.cURL = request.cURLDescription()
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        guard let data = response.data else { return }
            if let json = try? JSONSerialization
              .jsonObject(with: data, options: .mutableContainers) {
                print("\n\nResponse: \(json)")
                
                // TODO: Can implmemt this using Builder Pattern
                tempLog?.isSuccess = (response.error == nil)
                tempLog?.statusCode = String(describing: response.response?.statusCode ?? 0)
                tempLog?.responseData = String(describing: json)
                
                if let log = tempLog { logger.log(log) }
                tempLog = nil
            }
    }
        
}
