//
//  Post.swift
//  NetworkProject
//
//  Created by Данила Бондаренко on 01.10.2021.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let postId: Int
    let title: String
    let body: String

    enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
}
