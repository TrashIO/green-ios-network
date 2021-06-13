//
//  NetworkRequestInterceptor.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import Foundation
import Alamofire

class NetworkRequestInterceptor: RequestInterceptor {

     let retryLimit = 3
     let retryDelay: TimeInterval = 10
     
     func adapt( _ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
       //TODO:
        
       completion(.success(urlRequest))
     }
     
     func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
       let response = request.task?.response as? HTTPURLResponse
       //Retry for 5xx status codes
       if let statusCode = response?.statusCode,
         (500...599).contains(statusCode),
         request.retryCount < retryLimit {
           completion(.retryWithDelay(retryDelay))
       } else {
         return completion(.doNotRetry)
       }
     }
    
}
