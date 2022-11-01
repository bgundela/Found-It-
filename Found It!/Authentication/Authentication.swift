//
//  Authentication.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 9/24/22.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

class Authentication: ObservableObject {
    @Published var loginError: Bool = false
    @Published var loginMessage: String = ""
    @Published var registerError: Bool = false
    @Published var registerMessage: String = ""
    @Published var loginEmail: String = ""
    @Published var loginPassword: String = ""
    @Published var registerEmail: String = ""
    @Published var registerPassword: String = ""
    @Published var registerRePassword: String = ""
    @Published var signOutError: Bool = false
    @Published var signOutMessage: String = ""
    @Published var currentEmail: String = ""
    @Published var authenticated: Bool = false
    
    var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
    
    func login() {
        if loginEmail != "" || loginPassword != "" {
            Auth.auth().signIn(withEmail: loginEmail, password: loginPassword) { [weak self] res, err in
                if err != nil {
                    self?.loginMessage = err?.localizedDescription ?? "Registration Failed."
                    self?.loginError = true
                }
                
                DispatchQueue.main.async {
                    self?.authenticated = true
                    UserDefaults.standard.set(self?.loginEmail ?? "", forKey: "currentEmail")
                }
                //                UserDefaults.standard.set(true, forKey: "authenticated")
                //                NotificationCenter.default.post(name: NSNotification.Name("authenticated"), object: nil)
            }
        } else {
            self.loginMessage = "Please Enter An Email And Password."
            self.loginError = true
        }
    }
    
    func register() {
        if registerEmail != "" || registerPassword != "" {
            if registerPassword == registerRePassword {
                Auth.auth().createUser(withEmail: registerEmail, password: registerPassword) { [weak self] res, err in
                    if err != nil {
                        self?.registerMessage = err?.localizedDescription ?? "Registration Failed."
                        self?.registerError = true
                    } else {
                        Firestore.firestore().collection("users").addDocument(data: ["email": self!.registerEmail]) { [weak self] err in
                            if err != nil {
                                self?.registerMessage = err?.localizedDescription ?? "Registration Failed."
                                self?.registerError = true
                            }
                        }
                    
                        
                        DispatchQueue.main.async {
                            self?.authenticated = true
                            UserDefaults.standard.set(self?.registerEmail ?? "", forKey: "currentEmail")
                        }
                    }
                }
                
            } else {
                self.registerMessage = "Passwords Don't Match."
                self.registerError = true
            }
        } else {
            self.registerMessage = "Please Enter An Email And Password."
            self.registerError = true
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.authenticated = false
                UserDefaults.standard.set("", forKey: "currentEmail")
            }
            
            self.signOutMessage = "You have signed out. Please restart the app."
            self.signOutError = true
            
        } catch {
            self.signOutMessage = "Signing Out Unsuccessful. Please Try Again."
            self.signOutError = true
            return
        }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            if err != nil {
                self.signOutMessage = err!.localizedDescription
                self.signOutError = true
            }
            
            self.signOutMessage = "Successfully sent reset link."
            self.signOutError = true
        }
    }
}
