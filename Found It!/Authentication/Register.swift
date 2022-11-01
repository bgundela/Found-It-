//
//  Register.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 9/24/22.
//

import Foundation
import SwiftUI


struct Register: View {
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Register")
                .font(.custom("FuzzyBubbles-Bold", size: 40))
                .foregroundColor(Color("Yellow"))
            
            Spacer()
                
            
            TextField("Email...", text: self.$authentication.registerEmail)
                .autocapitalization(.none)
                .font(.custom("FuzzyBubbles-Regular", size: 20))
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                .padding()
            
            VStack {
                SecureField("Password...", text: self.$authentication.registerPassword)
                    .autocapitalization(.none)
                    .font(.custom("FuzzyBubbles-Regular", size: 20))
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                
                SecureField("Re-enter Password...", text: self.$authentication.registerRePassword)
                    .autocapitalization(.none)
                    .font(.custom("FuzzyBubbles-Regular", size: 20))
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
            }
            .padding()
                
            
            Button(action: {
                authentication.register()
                authentication.registerPassword = ""
                authentication.registerRePassword = ""
            }) {
                Text("Register")
                    .padding()
                    .foregroundColor(.white)
                    .font(.custom("FuzzyBubbles-Regular", size: 20))
                    .frame(width: UIScreen.main.bounds.width - 20)
                    .background(Color("Yellow"))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
            }
            
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .alert(isPresented: self.$authentication.registerError) {
            Alert(title: Text("Error"), message: Text(self.authentication.registerMessage), dismissButton: .default(Text("OK")))
        }
    }
}


