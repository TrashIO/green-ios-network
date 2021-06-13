//
//  APIEndpoint.swift
//  ios-network-module
//
//  Created by Abhishek on 12/06/21.
//

import Foundation
import Alamofire

public enum HttpVerb {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
    case HEAD
    
    func inHttpMethod() -> HTTPMethod {
        switch self {
        case .GET: return HTTPMethod.get
        case .POST: return HTTPMethod.post
        case .PUT: return HTTPMethod.put
        case .DELETE: return HTTPMethod.delete
        case .PATCH: return HTTPMethod.patch
        case .HEAD: return HTTPMethod.head
        }
    }
}

public protocol ApiRequestContract {
    var verb: HttpVerb { get set }
    var headers: [String: String] { get set }
    var body: [String: Any]? {get set }
    var path: URL { get set }
}

extension ApiRequestContract {
    
    func getParametersEncoded() -> Parameters? {
       return body
    }
    
    func getHeaders() -> HTTPHeaders {
        let data = self.headers.map { (key, value) -> HTTPHeader in
            return HTTPHeader(name: key, value: value)
        }
        return HTTPHeaders(data)
    }
}
