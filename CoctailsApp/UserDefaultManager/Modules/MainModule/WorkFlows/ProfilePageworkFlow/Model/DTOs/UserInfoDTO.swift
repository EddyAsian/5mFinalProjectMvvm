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
    let password: String
}
