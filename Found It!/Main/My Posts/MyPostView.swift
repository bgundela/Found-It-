//
//  MyPostView.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 10/29/22.
//

import Foundation
import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct MyPostView: View {
    @State var post: Post
    @State var imageURL: URL = URL(fileURLWithPath: "")
    @ObservedObject var homeModel = HomeModel()
    var body: some View {
        VStack {
            HStack {
                Text(post.title)
                    .font(.custom("FuzzyBubbles-Bold", size: 30))
                
                Spacer()
            }
            .padding()
            
            WebImage(url: imageURL)
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 40, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack {
                HStack {
                    Text(post.desc)
                        .lineLimit(6)
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                    
                    Spacer()
                }
                .padding(5)
                .padding(.leading, 5)
                
                HStack {
                    Text("Date Posted: \(post.date.formatted(.dateTime.day().month().year()))")
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                    
                    Spacer()
                }
                .padding(5)
                .padding(.leading, 5)
                
                if post.type == "Lost" {
                    HStack {
                        Text("Reward: $\(post.reward)")
                            .font(.custom("FuzzyBubbles-Regular", size: 20))
                        
                        Spacer()
                    }
                    .padding(5)
                    .padding(.leading, 5)
                }
                
                HStack {
                    Text("Location: \(post.state)")
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                    
                    Spacer()
                }
                .padding(5)
                .padding(.leading, 5)
                
                HStack {
                    Button(action: {
                        self.homeModel.deletePost(id: post.id)
                    }) {
                        Image(systemName: "trash.fill")
                            .font(.title)
                    }
                    
                    Spacer()
                }
                .padding(5)
                .padding(.leading, 5)
            }
            
            Spacer()
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width - 10, height: 600)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .onAppear() {
            loadImageFromFirebase(path: post.image)
        }
    }
    
    func loadImageFromFirebase(path: String) {
        let storageRef = Storage.storage().reference(withPath: "\(path)")
        storageRef.downloadURL { (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            self.imageURL = url!
        }
    }
}


struct MyPostView_Previews: PreviewProvider {
    static var previews: some View {
        MyPostView(post: Post(id: "regetrbg", title: "Waterbottle", desc: "Green Gatorade", email: "bhuvangundela2007@gmail.com", reward: 5, state: "MN", date: Date.now, image: "images/2A0EF807-E7B7-427D-8F8E-5CBA4FCCF56A.jpg", type: "Lost"))
    }
}
