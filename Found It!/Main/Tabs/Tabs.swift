//
//  Tabs.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 10/21/22.
//

import Foundation
import SwiftUI

struct Tabs: View {
    init() {
        UITabBar.appearance().barTintColor = .systemYellow
    }
    
    @State var selectedIndex = 0
    @State var modalIsPresented = false
    
    let tabBarImages = ["house.fill", "text.bubble", "plus.app.fill", "person"]
    
    var body: some View {
        VStack {
            ZStack {
                
                Spacer()
                    .fullScreenCover(isPresented: $modalIsPresented) {
                        AddPost()
                    }
                
                
                switch selectedIndex {
                case 0:
                    NavigationView {
                        Home()
                    }
                case 1:
                    NavigationView {
                        MyPosts()
                    }
                case 2:
                    Text("")
                case 3:
                    NavigationView {
                        Profile()
                    }
                default:
                    NavigationView {
                        Text("Home")
                    }
                }
            }
            
            Spacer()
            
            HStack {
                ForEach(0..<4) { num in
                    Spacer()
                    if num == 2 {
                        Button(action: {
                            selectedIndex = num
                            modalIsPresented = true
                        }) {
                            Image(systemName: tabBarImages[num])
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color("Yellow"))
                        }
                    } else {
                        Button(action: {
                            selectedIndex = num
                        }) {
                            Image(systemName: tabBarImages[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor((num == selectedIndex) ? .black : .init(white: 0.8))
                                .shadow(radius: (num == selectedIndex) ? 10 : 0)
                        }
                    }
                    
                    Spacer()
                }
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 50).stroke(Color("Yellow"), lineWidth: 5))
            .frame(width: UIScreen.main.bounds.width - 40)
            .padding()
        }
    }
}


struct Tabs_Previews: PreviewProvider {
    static var previews: some View {
        Tabs()
    }
}
