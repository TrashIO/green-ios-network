//
//  ApiManagerProtocol.swift
//  ios-network-module
//
//  Created by Abhishek on 12/06/21.
//

import Foundation

protocol ApiManagerProtocol {
    func request<T: Codable>(_ api: ApiRequestContract, onCompletion: @escaping(Result<T, Error>) -> Void)
}
