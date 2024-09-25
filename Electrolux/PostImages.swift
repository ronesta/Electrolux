//
//  PostImages.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 26.08.2024.
//

import Foundation

struct PostImages: Decodable {
    let photos: Photos
}

struct Photos: Decodable {
    let photo: [Photo]
}

struct Photo: Decodable, Equatable {
    let urlO: String?

    enum CodingKeys: String, CodingKey {
        case urlO = "url_o"
    }
}
