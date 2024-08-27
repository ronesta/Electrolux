//
//  ImageCache.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 26.08.2024.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}
