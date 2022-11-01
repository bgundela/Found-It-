//
//  SinglePost.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 10/29/22.
//

import Foundation
import SwiftUI
import FirebaseStorage
import SDWebImageSwiftUI

struct SinglePost: View {
    @State var post: Post
    @State var imageURL = URL(string: "")
    var body: some View {
        ScrollView {
            VStack {
//                HStack {
//                    NavigationLink(destination: Home()) {
//                        Image(systemName: "chevron.left")
//                            .bold()
//                            .foregroundColor(Color("Yellow"))
//                            .font(.title2)
//                    }
//
//                    Spacer()
//                }
                
                HStack {
                    Text(post.title)
                        .foregroundColor(Color("Yellow"))
                        .font(.custom("FuzzyBubbles-Bold", size: 40))
                    
                    Spacer()
                }
                .padding()
                
                WebImage(url: self.imageURL)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 20, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                HStack {
                    Text(post.desc)
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                    
                    Spacer()
                }
                .padding(5)
                
                HStack {
                    Text("Contact: \(post.email)")
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                    
                    Spacer()
                }
                .padding(5)
                
                if post.type == "Lost" {
                    HStack {
                        Text("Reward: $\(post.reward)")
                            .font(.custom("FuzzyBubbles-Regular", size: 20))
                        
                        Spacer()
                    }
                    .padding(5)
                }
                
                HStack {
                    Text("Location: \(post.state)")
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                    
                    Spacer()
                }
                .padding(5)
                
                if post.type == "Lost" {
                    HStack {
                        Text("Lost On: \(post.date.formatted(.dateTime.day().month().year()))")
                            .font(.custom("FuzzyBubbles-Regular", size: 20))
                        
                        Spacer()
                    }
                    .padding(5)
                } else {
                    HStack {
                        Text("Found On: \(post.date.formatted(.dateTime.day().month().year()))")
                            .font(.custom("FuzzyBubbles-Regular", size: 20))
                        
                        Spacer()
                    }
                    .padding(5)
                }
                
                if post.type == "Lost" {
                    Text("Found This?! Contact the owner by emailing them!")
                        .font(.custom("FuzzyBubbles-Bold", size: 20))
                        .padding(15)
                        .lineLimit(2)
                } else {
                    Text("Lost This?! Contact the finder by emailing them!")
                        .font(.custom("FuzzyBubbles-Bold", size: 20))
                        .padding(15)
                        .lineLimit(2)
                }
                
                Spacer()
            }
        }
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


struct SinglePost_Previews: PreviewProvider {
    static var previews: some View {
        SinglePost(post: Post(id: "regetrbg", title: "Waterbottle", desc: "Green Gatorade", email: "bhuvangundela2007@gmail.com", reward: 5, state: "MN", date: Date.now, image: "images/2A0EF807-E7B7-427D-8F8E-5CBA4FCCF56A.jpg", type: "Lost"))
    }
}
