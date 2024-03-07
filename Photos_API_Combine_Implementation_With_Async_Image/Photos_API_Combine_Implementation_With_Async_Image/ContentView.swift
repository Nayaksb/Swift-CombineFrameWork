//
//  ContentView.swift
//  Photos_API_Combine_Implementation_With_Async_Image
//
//  Created by Nayak on 2/19/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var photosData = APIPhotosHandler()
//    let slingPhotosData = photosData.photos
    
    var body: some View {
        List{
            ForEach(photosData.slingPhotos.photos){ photo in
                LazyHStack{
                    AsyncImage(url: URL(string: photo.url)) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 50, height: 50)
                        .padding()
                    
                    Text(photo.title)
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .frame(width: 200, height: 100, alignment: .leading)
                        .padding()
                    
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
