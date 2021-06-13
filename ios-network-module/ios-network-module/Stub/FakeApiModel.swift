//
//  FakeApiModel.swift
//  ios-network-module
//
//  Created by Abhishek on 13/06/21.
//

import Foundation

public struct UserResponseModel: Codable {
    let data: UserData?
    let support: SupportData?
    
    enum CodingKeys: String, CodingKey {
        case data
        case support
    }
}

public struct UserData: Codable {
    let id: Int?
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "email"
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "avatar"
    }
}

public struct SupportData: Codable {
    let url: String?
    let text: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case text
    }
}


public struct CreateUserResponseModel: Codable {
    let name: String?
    let job: String?
    let id: String?
    let createdAt: String?
}
