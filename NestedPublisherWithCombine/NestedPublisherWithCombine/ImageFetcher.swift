//
//  ImageFetcher.swift
//  NestedPublisherWithCombine
//
//  Created by Nayak on 3/16/24.
//

import Foundation
import Combine
import SwiftUI

class ImageFetcher: ObservableObject{
    
    
    
    let urlPaths = ["https://fastly.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68","https://fastly.picsum.photos/id/11/2500/1667.jpg?hmac=xxjFJtAPgshYkysU_aqx2sZir-kIOjNR9vx0te7GycQ","https://fastly.picsum.photos/id/12/2500/1667.jpg?hmac=Pe3284luVre9ZqNzv1jMFpLihFI6lwq7TPgMSsNXw2w", "https://fastly.picsum.photos/id/13/2500/1667.jpg?hmac=SoX9UoHhN8HyklRA4A3vcCWJMVtiBXUg0W4ljWTor7s", "https://fastly.picsum.photos/id/17/2500/1667.jpg?hmac=HD-JrnNUZjFiP2UZQvWcKrgLoC_pc_ouUSWv8kHsJJY"]
    @Published var image: UIImage? = nil
    
    let loadImage = CurrentValueSubject<String, Never>("")
    var cancelleable = Set<AnyCancellable>()
    
    init(){
        loadImage.sink{ [weak self] _ in
            self?.image = nil
        }
        .store(in: &cancelleable)
        loadImage
            .removeDuplicates()
            .compactMap{
                URL(string: $0)
            }
            .map{ (url) in
                URLSession.shared.dataTaskPublisher(for: url)
                    .map(\.data)
                    .compactMap{
                        UIImage(data: $0)
                    }
            }
            .switchToLatest()
            .receive(on: DispatchQueue.main)
            .sink{ completion in
                
                print("Completion : \(completion)")
                
            }receiveValue: { [weak self] (image) in
                self?.image = image
            }
            .store(in: &cancelleable)
    }
}
