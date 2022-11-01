//
//  AddPost.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 10/24/22.
//

import Foundation
import SwiftUI

struct AddPost: View {
    @State var title = ""
    @State var desc = ""
    @State var reward = 0
    @State var selectedLocation = "MN"
    @State var type = "Lost"
    @State var imagePicker: Bool = false
    @State var selectedImage: UIImage?
    @ObservedObject var homeModel = HomeModel()
    @Environment(\.presentationMode) var presentationMode
    @State var locations =  ["AL", "AK", "AZ", "AR", "CA", "CZ", "CO", "CT", "DE", "DC", "FL", "GA", "GU", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "TN", "TX", "UT", "VT", "VI", "VA", "WA", "WV", "WI", "MY", "EDEN PR. HIGH SCHOOL", "EAGLE RIDGE ACADEMY"]
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title.bold())
                            .foregroundColor(Color("Yellow"))
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "checkmark")
                            .font(.title.bold())
                            .foregroundColor(Color("Yellow"))
                            .padding()
                    }
                }
                
                TextField("Title...", text: $title)
                    .font(.custom("FuzzyBubbles-Regular", size: 20))
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                    .padding()
                
                TextField("Description...", text: $desc)
                    .font(.custom("FuzzyBubbles-Regular", size: 20))
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
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
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
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
            
                if self.type == "Lost" {
                    HStack {
                        TextField("Reward...", value: $reward, formatter: formatter)
                            .font(.custom("FuzzyBubbles-Regular", size: 20))
                            .frame(width: UIScreen.main.bounds.width / 5)
                            .keyboardType(.numberPad)
                            .padding()
                            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
                            .padding()
                        
                        Spacer()
                        
                    }
                }
                
                
                HStack {
                    Button(action: {
                        imagePicker = true
                    }) {
                        Text("Select a Photo")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("Yellow"))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding()
                    }
                    
                    Spacer()
                    
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .padding([.leading, .trailing])
                    }
                }

                if title != "" && desc != "" && selectedImage != nil {
                    Button(action: {
                        self.homeModel.addPost(title: self.title, desc: self.desc, email: "\(UserDefaults.standard.value(forKey: "currentEmail") as? String ?? "")", image: selectedImage!, reward: self.reward, state: self.selectedLocation, date: Date.now, type: self.type)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Add Post")
                            .padding()
                            .font(.custom("FuzzyBubbles-Bold", size: 20))
                            .frame(width: UIScreen.main.bounds.width - 20)
                            .foregroundColor(.white)
                            .background(Color("Yellow"))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
                
                
                Spacer()
                
            }
        }
        .sheet(isPresented: self.$imagePicker) {
            ImagePicker(selectedImage: $selectedImage, imagePickerShowing: $imagePicker)
        }
    }
}



struct AddPost_Previews: PreviewProvider {
    static var previews: some View {
        AddPost()
    }
}
