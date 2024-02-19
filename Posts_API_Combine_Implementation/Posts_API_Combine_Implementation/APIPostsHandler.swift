//
//  APIPostsHandler.swift
//  Posts_API_Combine_Implementation
//
//  Created by Nayak on 2/18/24.
//

import Foundation
import Combine

class APIPostsHandler: ObservableObject{
    @Published var posts: [PostsModel] = []
    var calcallable =  Set<AnyCancellable>()
    init(){
        getPosts()
    }
    func getPosts(){
        let urlPath = "https://jsonplaceholder.typicode.com/posts"
        guard let url = URL(string: urlPath) else {
            return
            
        }
        URLSession.shared
            .dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .sink{ (completion) in
                switch completion {

                case .finished:

                    print("Completion finished!") // debug statement

                case .failure(let error):

                    print("Completion failed -  \(error.localizedDescription)")
                    // debug statement
                }

            }

    receiveValue: { [weak self] (returnedPosts) in
    print("Returned Values : \(returnedPosts)")
    self?.posts = returnedPosts
            }
            .store(in: &calcallable)
            
    }
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let res = output.response as? HTTPURLResponse, res.statusCode >= 200 && res.statusCode <= 300 else{ throw URLError(.badServerResponse) }
        return output.data
    }
}

