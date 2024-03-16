//
//  ContentView.swift
//  NestedPublisherWithCombine
//
//  Created by Nayak on 3/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var imagefetcher = ImageFetcher()
    
    var body: some View {
        Text("Select the image to show!")
            .padding()
        List(imagefetcher.urlPaths, id: \.self) { path in
            Button(action: {
                imagefetcher.loadImage.send(path)
            }, label: {
                Text(path)
            })
        }
        ZStack{
            Color.gray
            
            if imagefetcher.image != nil {
                Image(uiImage: imagefetcher.image!)
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
