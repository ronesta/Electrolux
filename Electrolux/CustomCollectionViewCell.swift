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
    
    let image = UIImageView()
    
    let activityIndicator: UIActivityIndicatorView = {
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
        image.image = nil
    }
    
    private func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(activityIndicator)
        
        image.autoSetDimensions(to: CGSize(width: contentView.bounds.width, height: contentView.bounds.height))
        image.autoCenterInSuperview()
        
        activityIndicator.autoCenterInSuperview()
    }
    
    private func customizeCell() {
        backgroundColor = .clear
    }
    
    func configure(with photo: Photo) {
        activityIndicator.startAnimating()

        guard let currentUrlString = photo.urlO, let url = URL(string: currentUrlString) else {
            image.image = nil
            activityIndicator.stopAnimating()
            return
        }

        let cacheKey = NSString(string: currentUrlString)

        if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
            image.image = cachedImage
            activityIndicator.stopAnimating()
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                DispatchQueue.main.async {
                    self?.activityIndicator.stopAnimating()

                    if let error {
                        print("Ошибка загрузки изображения: \(error)")
                        self?.image.image = nil
                        return
                    }

                    if let data, let image = UIImage(data: data) {
                        ImageCache.shared.setObject(image, forKey: cacheKey)
                        self?.image.image = image
                    } else {
                        self?.image.image = nil
                    }
                }
            }.resume()
        }
    }
}
