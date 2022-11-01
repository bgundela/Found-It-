//
//  Profile.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 10/24/22.
//

import Foundation
import SwiftUI

struct Profile: View {
    @ObservedObject var authentication = Authentication()
    var body: some View {
        VStack {
            HStack {
                Text("Profile")
                    .font(.custom("FuzzyBubbles-Bold", size: 40))
                
                Spacer()
            }
            .padding()
            .padding(.bottom, 15)
            
            HStack {
                Text("Current User: \(UserDefaults.standard.value(forKey: "currentEmail") as? String ?? "Loading...")")
                    .font(.custom("FuzzyBubbles-Regular", size: 20))
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 20)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: Color("Yellow"), radius: 5)
            .padding()
            
            HStack {
                Button(action: {
                    self.authentication.signOut()
                    self.authentication.authenticated = self.authentication.isSignedIn
                }) {
                    Text("Log Out")
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                        .foregroundColor(.black)
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 20)
            .background(Color("Yellow"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: Color("Yellow"), radius: 5)
            .padding()
            
            HStack {
                Button(action: {
                    self.authentication.resetPassword(email: UserDefaults.standard.value(forKey: "currentEmail") as! String)
                }) {
                    Text("Reset Password")
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                        .foregroundColor(.black)
                }
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width - 20)
            .background(Color("Yellow"))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: Color("Yellow"), radius: 5)
            .padding()
            
            Spacer()
        }
        .alert(isPresented: self.$authentication.signOutError) {
            Alert(title: Text("Message"), message: Text(self.authentication.signOutMessage))
        }
    }
}


struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
