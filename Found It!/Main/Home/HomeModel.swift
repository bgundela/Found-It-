//
//  HomeModel.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 9/25/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

class HomeModel: ObservableObject {
    @Published var users = [User]()
    @Published var posts = [Post]()
    @Published var currentUserPosts = [Post]()
    @Published var lostPosts = [Post]()
    @Published var foundPosts = [Post]()
    @Published var locationFilteredPosts = [Post]()
    var selectedImage: UIImage?
    
    func getUsers() {
        Firestore.firestore().collection("users").getDocuments { res, err in
            if err != nil {
                print("error")
                return
            }
            
            if let res = res {
                self.users = res.documents.map { res in
                    return User(id: res.documentID, email: res["email"] as? String ?? "Error")
                }
            }
        }
    }
    
    func getPosts() {
        Firestore.firestore().collection("posts").getDocuments { res, err in
            if err != nil {
                print("error")
                return
            }
            
            if let res = res {
                self.posts = res.documents.map { res in
                    return Post(id: res.documentID, title: res["title"] as? String ?? "Error", desc: res["desc"] as? String ?? "Error", email: res["email"] as? String ?? "Error", reward: res["reward"] as? Int ?? 0, state: res["state"] as? String ?? "MN", date: res["date"] as? Date ?? Date.now, image: res["image"] as? String ?? "", type: res["type"] as? String ?? "")
                }
            }
        }
    }
    
    func getCurrentUserPosts() {
        Firestore.firestore().collection("posts").whereField("email", in: [(UserDefaults.standard.value(forKey: "currentEmail") as? String ?? "")]).getDocuments { res, err in
            if err != nil {
                print("error")
                return
            }
            
            if let res = res {
                self.currentUserPosts = res.documents.map { res in
                    return Post(id: res.documentID, title: res["title"] as? String ?? "Error", desc: res["desc"] as? String ?? "Error", email: res["email"] as? String ?? "Error", reward: res["reward"] as? Int ?? 0, state: res["state"] as? String ?? "MN", date: res["date"] as? Date ?? Date.now, image: res["image"] as? String ?? "", type: res["type"] as? String ?? "")
                }
            }
        }
    }
    
    func getLostPosts() {
        Firestore.firestore().collection("posts").whereField("type", in: ["Lost"]).getDocuments { res, err in
            if err != nil {
                print("error")
                return
            }
            
            if let res = res {
                self.lostPosts = res.documents.map { res in
                    return Post(id: res.documentID, title: res["title"] as? String ?? "Error", desc: res["desc"] as? String ?? "Error", email: res["email"] as? String ?? "Error", reward: res["reward"] as? Int ?? 0, state: res["state"] as? String ?? "MN", date: res["date"] as? Date ?? Date.now, image: res["image"] as? String ?? "", type: res["type"] as? String ?? "")
                }
            }
        }
    }
    
    func getFoundPosts() {
        Firestore.firestore().collection("posts").whereField("type", in: ["Found"]).getDocuments { res, err in
            if err != nil {
                print("error")
                return
            }
            
            if let res = res {
                self.foundPosts = res.documents.map { res in
                    return Post(id: res.documentID, title: res["title"] as? String ?? "Error", desc: res["desc"] as? String ?? "Error", email: res["email"] as? String ?? "Error", reward: res["reward"] as? Int ?? 0, state: res["state"] as? String ?? "MN", date: res["date"] as? Date ?? Date.now, image: res["image"] as? String ?? "", type: res["type"] as? String ?? "")
                }
            }
        }
    }
    
    func getLocationFilteredPosts(location: String) {
        Firestore.firestore().collection("posts").whereField("state", in: [location]).getDocuments { res, err in
            if err != nil {
                print("error")
                return
            }
            
            if let res = res {
                self.locationFilteredPosts = res.documents.map { res in
                    return Post(id: res.documentID, title: res["title"] as? String ?? "Error", desc: res["desc"] as? String ?? "Error", email: res["email"] as? String ?? "Error", reward: res["reward"] as? Int ?? 0, state: res["state"] as? String ?? "MN", date: res["date"] as? Date ?? Date.now, image: res["image"] as? String ?? "", type: res["type"] as? String ?? "")
                }
            }
        }
    }
    
    func addPost(title: String, desc: String, email: String, image: UIImage, reward: Int, state: String, date: Date, type: String) {
        let imageData = image.jpegData(compressionQuality: 0.8)
        let storageRef = Storage.storage().reference()
        
        guard imageData != nil else {
            print("failed")
            return
        }
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, err in
            if err == nil && metadata != nil {
                
            }
        }
        
        Firestore.firestore().collection("posts").addDocument(data: ["title": title, "desc": desc, "email": email, "reward": reward, "state": state, "date": date, "image": path, "type": type]) { err in
            if err != nil {
                print("error")
                return
            }
        }
    }
    
    func deletePost(id: String) {
        Firestore.firestore().collection("posts").document(id).delete() { err in
            if err != nil {
                print(err)
            }
        }
    }
    
    func getPhoto(documentID: String) {
        var photo = ""
        Firestore.firestore().collection("posts").document(documentID).getDocument { res, err in
            if err == nil && res != nil {
                photo = res!.documentID
            }
        }
        
        print(photo)
    }
}

// 
