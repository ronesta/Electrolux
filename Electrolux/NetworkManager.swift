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

    private let urlString = "https://flickr.com/services/rest/?method=flickr.photos.search&api_key=1a958538e8bb6e25cf246b9c8a98a8c2&tags=electrolux&format=json&nojsoncallback=1&extras=url_o"

    private let session = URLSession.shared

    func loadImages(completion: @escaping (Result<[Photo], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NetworkError.invalidURL))
            return
        }

        session.dataTask(with: url) { data, _, error in
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
                let photos = try JSONDecoder().decode(PostImages.self, from: data)
                let items = photos.photos.photo.compactMap {
                    $0.urlO != nil ? $0 : nil
                }.prefix(20)
                completion(.success(Array(items)))
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
