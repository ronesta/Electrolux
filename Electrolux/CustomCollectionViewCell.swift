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

    var currentImageURL: String?

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

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

    func configure(with image: UIImage?) {
        imageView.image = image
    }
}
