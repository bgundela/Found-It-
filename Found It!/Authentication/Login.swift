//
//  Login.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 9/24/22.
//

import Foundation
import SwiftUI


struct Login: View {
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Login")
                .font(.custom("FuzzyBubbles-Bold", size: 40))
            
            Spacer()
            
            TextField("Email...", text: $authentication.loginEmail)
                .autocapitalization(.none)
                .font(.custom("FuzzyBubbles-Regular", size: 20))
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                .padding()
            
            SecureField("Password...", text: self.$authentication.loginPassword)
                .autocapitalization(.none)
                .font(.custom("FuzzyBubbles-Regular", size: 20))
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                .padding([.top, .leading, .trailing])
            
            HStack {
                Spacer()
                
                if self.authentication.loginEmail != "" {
                    Button(action: {
                        self.authentication.resetPassword(email: self.authentication.loginEmail)
                        self.authentication.loginMessage = "Successfully sent password reset link."
                        self.authentication.loginError = true
                    }) {
                        Text("Forgot Password?")
                            .font(.custom("FuzzyBubbles-Regular", size: 20))
                            .foregroundColor(.black)
                    }
                }
                
            }
            .padding()
                
            Button(action: {
                authentication.login()
            }) {
                Text("Login")
                    .padding()
                    .foregroundColor(Color("Yellow"))
                    .font(.custom("FuzzyBubbles-Regular", size: 20))
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .background(Color.black)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
            }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color("Yellow"))
        .alert(isPresented: self.$authentication.loginError) {
            Alert(title: Text("Message"), message: Text(self.authentication.loginMessage), dismissButton: .default(Text("OK")))
        }
    }
}
