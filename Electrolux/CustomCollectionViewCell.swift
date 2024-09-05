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
        costomizeCell()
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
    
    private func costomizeCell() {
        backgroundColor = .clear
    }
    
    func configure(with photo: Photo) {
        activityIndicator.startAnimating()
        if let currentUrlString = photo.urlO {
            let cacheKey = NSString(string: currentUrlString)
            
            if let cachedImage = ImageCache.shared.object(forKey: cacheKey) {
                image.image = cachedImage
                activityIndicator.stopAnimating()
            } else {
                guard let url = URL(string: currentUrlString) else {
                    image.image = nil
                    activityIndicator.stopAnimating()
                    return
                }
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url),
                       let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            ImageCache.shared.setObject(image, forKey: cacheKey)
                            self.image.image = image
                            self.activityIndicator.stopAnimating()
                        }
                    }
                }
            }
        }
    }
}
