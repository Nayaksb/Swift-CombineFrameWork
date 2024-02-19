//
//  PostsModel.swift
//  Posts_API_Combine_Implementation
//
//  Created by Nayak on 2/18/24.
//

import Foundation

struct PostsModel: Identifiable, Codable{
    let id: Int
    let userId: Int
    let title: String
    let body: String
}
