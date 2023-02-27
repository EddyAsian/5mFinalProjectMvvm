//
//  UserInfoDTO.swift
//  CoctailsApp
//
//  Created by Eldar on 22/2/23.
//

import Foundation

struct UserInfo: Codable {
    let email: String
    let dateOfBirth: String
    let adress: String
    let loginName: String
    let password: String
}

public struct UserKeys {
    static let name = "UserName"
    static let surname = "UserSurname"
    static let birthDate = "UserBirthDate"
    static let address = "UserAddress"
}

public struct AuthKeys {
    static let uid = "UserID"
    static let phoneNumber = "UserPhoneNumber"
    static let credentialProvider = "CredentialProvider"
}
