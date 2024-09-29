//
//  ImageLoader.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 29.09.2024.
//

import Foundation
import UIKit

final class ImageLoader {
    static let shared = ImageLoader()
    private init() {}

    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)

        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            completion(cachedImage)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print(error.localizedDescription)
                completion(nil)
                return
            }

            if let data,
               let image = UIImage(data: data) {
                ImageCache.shared.setObject(image, forKey: cacheKey)
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
