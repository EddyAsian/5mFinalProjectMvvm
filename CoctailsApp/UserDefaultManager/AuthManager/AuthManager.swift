//
//  AuthManager.swift
//  CoctailsApp
//
//  Created by Eldar on 21/2/23.
//

import Foundation
import FirebaseCore
import Firebase
import FirebaseAuth

class AuthManager  {
    
    let profileVC = ProfileViewController()
    
    static let shared = AuthManager()
    
    private init() { }
    
//    private let phoneNumber = "+996707848894"
    
    private var verificationId: String?
    
    func authentificateWithPN() {
        let sms = AddNumberViewController()
        guard let phoneNumber = sms.smsCode.text else { return  }
        PhoneAuthProvider.provider().verifyPhoneNumber(
            phoneNumber, uiDelegate: nil
        ) { verificationID, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            self.verificationId = verificationID
        }
    }
    
    func verifyPhoneAuthTapped() {
        let authServiceViewController = AuthServiceViewController()
        
        guard let code = authServiceViewController.codeInformation.text,
              let vID = verificationId else {
            return
        }
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: vID,
            verificationCode: code
        )
        authInCocktailsApp(with: credential)
    }
    
    func authInCocktailsApp(with credential: PhoneAuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("error is: \(error.localizedDescription)")
            } else {
                print("Authorized: \(authResult?.user)")
                self.profileVC.clearKeychain()
                self.profileVC.saveUserDefaultManager()
                self.profileVC.saveKeyChainManager()
            }
        }
    }
}
