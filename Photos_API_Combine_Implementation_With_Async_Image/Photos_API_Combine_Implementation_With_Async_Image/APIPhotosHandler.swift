//
//  APIPhotosHandler.swift
//  Photos_API_Combine_Implementation_With_Async_Image
//
//  Created by Nayak on 2/19/24.
//

import Foundation
import Combine
import UIKit

class APIPhotosHandler: ObservableObject{
//    @Published var photos : [PhotosModel] = []
    @Published var slingPhotos : SlingAcademyPhotos = SlingAcademyPhotos(success: false, total_photos: 0, message: "", photos: [])
    var cancellable = Set<AnyCancellable>()
    
    init(){
        getPhotos()
    }
    func getPhotos(){
        
//        let urlPath = "https://jsonplaceholder.typicode.com/photos"
        let urlPath = "https://api.slingacademy.com/v1/sample-data/photos?offset=5&limit=20"
        
        guard let url = URL(string: urlPath) else { return }
        
        URLSession.shared
            .dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
//            .map(\.data)
            .tryMap(handleOutput)
            .decode(type: SlingAcademyPhotos.self, decoder: JSONDecoder())
            .sink{ (complition) in
                switch complition {
                case .finished:
                    print("API Call Finished!")
                case .failure (let error):
                    print("API Call Failed with \(error.localizedDescription)")
                }
            }
        receiveValue: { [weak self] (returnedPhotos) in
//          self?.photos = returnedPhotos
            print(returnedPhotos)
            self?.slingPhotos = returnedPhotos
            
        }
            .store(in: &cancellable)
        
    }
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data{
        guard let res = output.response as? HTTPURLResponse, res.statusCode >= 200 && res.statusCode <= 300  else { throw URLError(.badServerResponse) }
        return output.data
    }
    
}
