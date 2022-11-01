//
//  MyPosts.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 10/24/22.
//

import Foundation
import SwiftUI

struct MyPosts: View {
    @ObservedObject var homeModel: HomeModel = HomeModel()
    var body: some View {
        VStack {
            HStack {
                Text("My Posts")
                    .font(.custom("FuzzyBubbles-Bold", size: 40))
                
                Spacer()
                
            }
            .padding()
            
            Spacer()
            
            ScrollView {
                VStack {
                    ForEach(self.homeModel.currentUserPosts, id: \.id) { post in
                        MyPostView(post: post)
                    }
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("Yellow"))
        }
        .onAppear() {
            print((UserDefaults.standard.value(forKey: "currentEmail") as? String ?? ""))
            self.homeModel.getCurrentUserPosts()
        }
    }
}


struct MyPosts_Previews: PreviewProvider {
    static var previews: some View {
        MyPosts()
    }
}
