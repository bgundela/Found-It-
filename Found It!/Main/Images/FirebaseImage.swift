//
//  FirebaseImage.swift
//  Found It!
//
//  Created by Bhuvan Gundela on 10/29/22.
//

import Foundation
import SwiftUI
import Combine
import FirebaseStorage

let placeholder = UIImage(named: "placeholder.jpg")!

struct FirebaseImage: View {
    
    init(id: String) {
        self.imageLoader = Loader(id)
    }
    
    @ObservedObject var imageLoader: Loader
    
    var image: UIImage? {
        imageLoader.data.flatMap(UIImage.init)
    }
    
    var body: some View {
        Image(uiImage: image ?? placeholder)
            .resizable()
    }
}

final class Loader : ObservableObject {
    let didChange = PassthroughSubject<Data?, Never>()
    var data: Data? = nil {
        didSet { didChange.send(data) }
    }

    init(_ id: String){
        // the path to the image
        let url = "images/\(id)"
        let storage = Storage.storage()
        let ref = storage.reference().child(url)
        ref.getData(maxSize: 1 * 2048 * 2048) { data, error in
            if let error = error {
                print("\(error)")
            }

            DispatchQueue.main.async {
                self.data = data
            }
        }
    }
}
