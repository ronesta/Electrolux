//
//  ProductCardViewController.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 18.08.2024.
//

import UIKit

final class ProductCardViewController: UIViewController {
    private let productImage = UIImageView()
    private var imageURL: URL?

    init(imageURL: URL) {
        self.imageURL = imageURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        installationImage()
    }

    private func setupViews() {
        view.addSubview(productImage)
        view.backgroundColor = .systemGray5

        productImage.contentMode = .scaleAspectFit
        productImage.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        productImage.autoPinEdge(toSuperviewSafeArea: .top)
    }

    private func installationImage() {
        guard let imageURL else {
            return
        }

        let cacheKey = NSString(string: imageURL.absoluteString)

        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            productImage.image = cachedImage
        }
    }
}
