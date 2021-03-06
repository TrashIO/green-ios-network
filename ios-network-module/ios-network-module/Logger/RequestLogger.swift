//
//  RequestLogger.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import Foundation

struct ApiLogRequestModel {
    var timeStamp: Date
    var httpVerb: String?
    var cURL: String?
    var responseData: String?
    var statusCode: String?
    var endpoint: String
    var isSuccess: Bool?
    
    func toDetailType() -> [DetailViewType] {
        var data: [DetailViewType] = []
        data.append(.heading(endpoint))
        data.append(.curl(cURL ?? ""))
        data.append(.responseJSON(responseData ?? ""))
        
        return data
    }
}

class RequestLogger {
    
    var dataSource = [ApiLogRequestModel]() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("NetworkLogsUpdated"), object: self.dataSource)
        }
    }
    
    static let shared = RequestLogger()
    private init() {}
    
    func log(_ request: ApiLogRequestModel) {
        self.dataSource.append(request)
    }
}
