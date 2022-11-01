//
//  Landing.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 10/30/22.
//

import Foundation
import SwiftUI

struct Landing: View {
    @State var selectedTab: String = "Login"
    @Namespace var animation
    var body: some View {
        ZStack {
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            self.selectedTab = "Login"
                        }
                    }) {
                        if selectedTab == "Login" {
                            VStack {
                                Text("Login")
                                    .foregroundColor(.black)
                                    .font(.title3.bold())
                                    .padding([.top, .leading, .trailing])
                                
                                Divider()
                                    .background(Color.white)
                                    .frame(width: 35)
                                    .matchedGeometryEffect(id: "TYPE", in: animation, properties: .frame)
                            }
                            
                        } else {
                            Text("Login")
                                .foregroundColor(Color.gray.opacity(0.5))
                                .font(.title3)
                                .padding()
                        }
                    }
                    
                    Divider()
                        .frame(height: 15)
                    
                    Button(action: {
                        withAnimation {
                            self.selectedTab = "Register"
                        }
                    }) {
                        if selectedTab == "Register" {
                            VStack {
                                Text("Register")
                                    .foregroundColor(.black)
                                    .font(.title3.bold())
                                    .padding([.top, .leading, .trailing])
                                
                                Divider()
                                    .background(Color.black)
                                    .frame(width: 35)
                                    .matchedGeometryEffect(id: "TYPE", in: animation, properties: .frame)
                            }
                            
                        } else {
                            Text("Register")
                                .foregroundColor(Color.gray.opacity(0.5))
                                .font(.title3)
                                .padding()
                        }
                    }
                }
                .padding()
                .animation(.easeInOut, value: self.selectedTab)
                .padding(.top, 25)
                
                Spacer()
            }
            .zIndex(1)
            
            if selectedTab == "Login" {
                Login()
            } else {
                Register()
            }
        }
    }
}
