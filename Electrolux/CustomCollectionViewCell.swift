//
//  CustomCollectionViewCell.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 18.08.2024.
//

import UIKit
import PureLayout

final class CustomCollectionViewCell: UICollectionViewCell {
    static let id = "CustomCollectionViewCell"

    private let imageView = UIImageView()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    private var photo: Photo?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        customizeCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        activityIndicator.stopAnimating()
    }

    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(activityIndicator)

        imageView.autoSetDimensions(to: CGSize(width: contentView.bounds.width, height: contentView.bounds.height))
        imageView.autoCenterInSuperview()

        activityIndicator.autoCenterInSuperview()
    }

    private func customizeCell() {
        backgroundColor = .clear
    }

    func configure(with photo: Photo) {
        self.photo = photo
        activityIndicator.startAnimating()

        guard let currentUrlString = photo.urlO, let url = URL(string: currentUrlString) else {
            imageView.image = nil
            activityIndicator.stopAnimating()
            return
        }

        let cacheKey = NSString(string: currentUrlString)

        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            imageView.image = cachedImage
            activityIndicator.stopAnimating()
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                DispatchQueue.main.async {
                    if let error {
                        print("Failed to load image data: \(error)")
                        return
                    }

                    if let data,
                       let image = UIImage(data: data),
                       photo == self?.photo {
                        ImageCache.shared.setObject(image, forKey: cacheKey)
                        self?.imageView.image = image
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }.resume()
        }
    }
}
