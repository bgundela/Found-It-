//
//  Home.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 9/24/22.
//

import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import SDWebImageSwiftUI

struct Home: View {
    @EnvironmentObject var authentication: Authentication
    @State var imagePicker: Bool = false
    @State var selectedImage: UIImage?
    @ObservedObject var homeModel: HomeModel = HomeModel()
    @State var image = ""
    @State var search = ""
    @State var type = "Lost"
    @State var searchedLostPosts = [Post]()
    @State var searchedFoundPosts = [Post]()
    @State var searched = true
    @State var locations =  ["EDEN PR. HIGH SCHOOL", "EAGLE RIDGE ACADEMY", "AL", "AK", "AZ", "AR", "CA", "CZ", "CO", "CT", "DE", "DC", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "MY"]
    @State var selectedLocation = "MN"
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Home")
                        .font(.custom("FuzzyBubbles-Bold", size: 40))
                    
                    Spacer()
                    
                    Text("\(Date.now.formatted(.dateTime.day().month().year()))")
                        .font(.custom("FuzzyBubbles-Regular", size: 30))
                    
                }
                .padding()
                
                HStack {
                    if self.type == "Lost" {
                        Group {
                            Button(action: {
                                withAnimation {
                                    self.type = "Lost"
                                }
                            }) {
                                Text("Lost")
                                    .foregroundColor(.black)
                                    .bold()
                                    .font(.title3)
                                    .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                            }
                        }
                        .overlay(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.5)))
                    } else {
                        Button(action: {
                            withAnimation {
                                self.type = "Lost"
                            }
                        }) {
                            Text("Lost")
                                .foregroundColor(.black)
                                .bold()
                                .font(.title3)
                                .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                        }
                    }
                    
                    Divider()
                        .overlay(.black)
                        .frame(height: 20)
                    
                    Button(action: {
                        withAnimation {
                            self.type = "Found"
                        }
                        
                    }) {
                        if self.type == "Found" {
                            Group {
                                Button(action: {
                                    self.type = "Found"
                                }) {
                                    Text("Found")
                                        .foregroundColor(.black)
                                        .bold()
                                        .font(.title3)
                                        .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.5)))
                        } else {
                            Button(action: {
                                withAnimation {
                                    self.type = "Found"
                                }
                            }) {
                                Text("Found")
                                    .foregroundColor(.black)
                                    .bold()
                                    .font(.title3)
                                    .frame(width: (UIScreen.main.bounds.width - 60) / 2)
                            }
                        }
                    }
                }
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                .padding()
                
                HStack {
                    Text("Location: ")
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                        .padding()
                    
                    Spacer()
                    
                    
                    Menu {
                        ForEach(self.locations, id: \.self) { location in
                            Button(action: {
                                self.selectedLocation = location
                                self.homeModel.getLocationFilteredPosts(location: self.selectedLocation)
                            }) {
                                Text(location)
                            }
                        }
                    } label: {
                        Text("Choose")
                            .foregroundColor(Color("Yellow"))
                            .font(.custom("FuzzyBubbles-Regular", size: 20))
                            .padding(10)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding()
                    }
                    
                    Spacer()
                    
                    Text("\(selectedLocation)")
                    
                    Spacer()
                    
                }
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                .padding()
                
                HStack {
                    Text("I want to: ")
                        .font(.custom("FuzzyBubbles-Regular", size: 20))
                        .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        self.searched = true
                    }) {
                        if searched {
                            Text("Search")
                                .font(.custom("FuzzyBubbles-Regular", size: 20))
                                .foregroundColor(Color("Yellow"))
                                .padding(10)
                                .background(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } else {
                            Text("Search")
                                .font(.custom("FuzzyBubbles-Regular", size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(5)
                    
                    Button(action: {
                        self.searched = false
                    }) {
                        if !searched {
                            Text("Browse")
                                .font(.custom("FuzzyBubbles-Regular", size: 20))
                                .foregroundColor(Color("Yellow"))
                                .padding(10)
                                .background(Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                        } else {
                            Text("Browse")
                                .font(.custom("FuzzyBubbles-Regular", size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(5)
                }
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                .padding()
            }
            .background(Color("Yellow"))
            
//            if self.type == "Lost" {
//                if self.searched != true {
//                    List(self.homeModel.lostPosts, id: \.id) { post in
//                        PostView(post: post)
//                    }
//                } else {
//                    List(self.searchedLostPosts, id: \.id) { post in
//                        PostView(post: post)
//                    }
//                }
//            } else {
//                if self.searched != true {
//                    List(self.homeModel.foundPosts, id: \.id) { post in
//                        PostView(post: post)
//                    }
//                } else {
//                    List(self.searchedFoundPosts, id: \.id) { post in
//                        PostView(post: post)
//                    }
//                }
//            }
            
            if self.type == "Lost" {
                if searched {
                    List(self.searchedLostPosts, id: \.id) { post in
                        if post.type == "Lost" {
                            NavigationLink(destination: SinglePost(post: post)) {
                                PostView(post: post)
                            }
                        }
                    }
                    .searchable(text: self.$search)
                    .onChange(of: self.search) { search in
                        if !search.isEmpty {
                            self.searchedLostPosts = self.homeModel.lostPosts.filter { $0.title.contains(search) }
                        }
                    }
                } else {
                    List(self.homeModel.locationFilteredPosts, id: \.id) { post in
                        if post.type == "Lost" {
                            NavigationLink(destination: SinglePost(post: post)) {
                                PostView(post: post)
                            }
                        }
                    }
                }
            } else {
                if searched {
                    List(self.searchedFoundPosts, id: \.id) { post in
                        if post.type == "Found" {
                            NavigationLink(destination: SinglePost(post: post)) {
                                PostView(post: post)
                            }
                        }
                    }
                    .searchable(text: self.$search)
                    .onChange(of: self.search) { search in
                        if !search.isEmpty {
                            self.searchedFoundPosts = self.homeModel.foundPosts.filter { $0.title.contains(search) }
                        }
                    }
                } else {
                    List(self.homeModel.locationFilteredPosts, id: \.id) { post in
                        if post.type == "Found" {
                            NavigationLink(destination: SinglePost(post: post)) {
                                PostView(post: post)
                            }
                        }
                    }
                }
                
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.secondary.opacity(0.1))
        .onAppear() {
            self.searched = true
            self.homeModel.getFoundPosts()
            self.homeModel.getLostPosts()
            self.searchedLostPosts = self.homeModel.locationFilteredPosts
            self.searchedFoundPosts = self.homeModel.locationFilteredPosts
            self.homeModel.getLocationFilteredPosts(location: self.selectedLocation)
        }
    }
    
    func searchLostPosts() {
        self.searchedLostPosts = self.searchedLostPosts.filter { $0.title.localizedCaseInsensitiveContains(self.search) }
    }
    
    func searchFoundPosts() {
        self.searchedFoundPosts = self.searchedFoundPosts.filter { $0.title.localizedCaseInsensitiveContains(self.search) }
    }

}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//VStack {
//    Text("Current User: \(UserDefaults.standard.value(forKey: "currentEmail") as? String ?? "")")
//    List(homeModel.currentUserPosts, id: \.id) { post in
//        VStack {
//            Text("\(post.title): \(post.id)")
//        }
//    }
//    if selectedImage != nil {
//        Image(uiImage: selectedImage!)
//            .resizable()
//            .frame(width: 200, height: 200)
//
//        Button(action: {
//            self.homeModel.addPost(title: "Bottle", desc: "Yellow", email: "\(UserDefaults.standard.value(forKey: "currentEmail") as? String ?? "")", image: selectedImage!, reward: 5, state: "MN", date: Date.now, type: "Lost")
//        }) {
//            Text("Add Post")
//        }
//    }
//    Button(action: {
//        self.authentication.signOut()
//    }) {
//        Text("Logout")
//    }
//
//    Button(action: {
//        imagePicker = true
//    }) {
//        Text("Select a Photo")
//    }
//}
//.alert(isPresented: self.$authentication.signOutError) {
//    Alert(title: Text("Error"), message: Text(self.authentication.signOutMessage), dismissButton: .default(Text("OK")))
//}
//.onAppear() {
//    self.homeModel.getUsers()
//    self.homeModel.getPosts()
//    self.homeModel.getCurrentUserPosts()
//}
//.sheet(isPresented: self.$imagePicker) {
//    ImagePicker(selectedImage: $selectedImage, imagePickerShowing: $imagePicker)
//}
