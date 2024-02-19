//
//  ContentView.swift
//  Posts_API_Combine_Implementation
//
//  Created by Nayak on 2/18/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var postObj = APIPostsHandler()
    var body: some View {
        List{
            ForEach(postObj.posts) { post in
                VStack{
                    Text(post.title)
                        .font(.headline)
                        .padding()
                    Text(post.body)
                        .foregroundColor(.gray)
                        .font(.body)
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
