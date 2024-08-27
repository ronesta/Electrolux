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

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    let image = UIImageView()

    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        costomizeCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(activityIndicator)

        image.autoSetDimensions(to: CGSize(width: contentView.bounds.width, height: contentView.bounds.height))
        image.autoCenterInSuperview()

        activityIndicator.autoCenterInSuperview()
    }

    private func costomizeCell() {
        backgroundColor = .clear
    }
}
