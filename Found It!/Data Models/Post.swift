//
//  Post.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 9/27/22.
//

import Foundation
import Firebase

struct Post: Identifiable {
    var id: String
    var title: String
    var desc: String
    var email: String
    var reward: Int
    var state: String
    var date: Date
    var image: String
    var type: String
}
