//
//  PhotosModel.swift
//  Photos_API_Combine_Implementation_With_Async_Image
//
//  Created by Nayak on 2/19/24.
//

import Foundation

struct PhotosModel: Identifiable, Codable{
    let id: Int
    let albumId: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

struct SlingAcademyPhotos: Codable{
    let success: Bool
    let total_photos: Int
    let message: String
//    let limit: Int
    let photos: [SlingPhotosModel]
}
struct SlingPhotosModel: Identifiable, Codable{
    let id: Int
    let user: Int
    let title: String
    let url: String
    let description: String
}
