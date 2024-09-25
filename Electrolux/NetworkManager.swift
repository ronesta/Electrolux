//
//  NetworkManager.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 18.08.2024.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}

    // swiftlint:disable line_length
    private let urlString = "https://flickr.com/services/rest/?method=flickr.photos.search&api_key=1a958538e8bb6e25cf246b9c8a98a8c2&tags=electrolux&format=json&nojsoncallback=1&extras=url_o"
    // swiftlint:enable line_length

    func loadImages(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }

            guard let data else {
                print("No data")
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                let response = try JSONDecoder().decode(PostImages.self, from: data)
                var items = [Photo]()
                for photo in response.photos.photo where photo.urlO != nil {
                    items.append(photo)
                    if items.count == 20 {
                        break
                    }
                }
                completion(.success(items))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
