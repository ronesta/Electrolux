//
//  PostImages.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 26.08.2024.
//

import Foundation

struct PostImages: Codable {
    let photos: Photos
}

struct Photos: Codable {
    let photo: [Photo]
}

struct Photo: Codable {
    let urlO: String?

    enum CodingKeys: String, CodingKey {
        case urlO = "url_o"
    }
}
