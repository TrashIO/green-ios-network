//
//  NetworkError.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import Foundation

enum NetworkError: Error {
    case parsingError(String)
    case network(String?)
}
