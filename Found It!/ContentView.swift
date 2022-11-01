//
//  ContentView.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 9/24/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
//    @State var authenticated = UserDefaults.standard.value(forKey: "authenticated") as? Bool ?? false
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        VStack {
            if authentication.authenticated {
                Tabs()
            } else {
                Landing()
            }
        }
        .onAppear() {
            authentication.authenticated = authentication.isSignedIn
        }
    }
}


