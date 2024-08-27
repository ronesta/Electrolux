//
//  ViewController.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 14.08.2024.
//

import UIKit
import PureLayout

final class FirstViewController: UIViewController {

    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2.5), height: (UIScreen.main.bounds.width / 2.5))
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 50
        layout.sectionInset = UIEdgeInsets(top: 11, left: 11, bottom: 10, right: 11)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(
            CustomCollectionViewCell.self,
            forCellWithReuseIdentifier: CustomCollectionViewCell.id
        )

        return collectionView
    }()

    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        loadImages()
    }

    private func setupNavigationBar() {
        title = "First Tab"
    }

    private func setupViews() {
        view.backgroundColor = .systemGray6
        view.addSubview(searchBar)
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self

        searchBar.autoAlignAxis(toSuperviewAxis: .vertical)
        searchBar.autoPinEdge(toSuperviewSafeArea: .top)
        searchBar.autoPinEdge(toSuperviewEdge: .leading)
        searchBar.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPinEdge(.top, to: .bottom, of: searchBar)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }

    private func loadImages() {
        NetworkManager.shared.loadImages { [weak self] result in
            switch result {
            case .success(let photos):
                self?.photos = photos
                print("Successfully loaded \(photos.count) photos.")
            case .failure(let error):
                print("Failed to load images with error: \(error.localizedDescription)")
            }

            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension FirstViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.id, for: indexPath) as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }

        let photo = photos[indexPath.item]
        guard let currentUrlString = photo.urlO, let currentUrl = URL(string: currentUrlString) else {
            return cell
        }

        cell.image.image = nil
        cell.activityIndicator.startAnimating()

        if let cachedImage = ImageCache.shared.object(forKey: currentUrlString as NSString) {
            cell.image.image = cachedImage
            cell.activityIndicator.stopAnimating()
        } else {
            URLSession.shared.dataTask(with: currentUrl) { data, response, error in
                if error != nil {
                    print("Data Task Error:", error!.localizedDescription)
                    return
                }

                guard let data = data, let image = UIImage(data: data) else {
                    print("Invalid Data or Image")
                    return
                }

                ImageCache.shared.setObject(image, forKey: currentUrlString as NSString)

                DispatchQueue.main.async {
                    if let visibleCell = collectionView.cellForItem(at: indexPath) as? CustomCollectionViewCell {
                        visibleCell.image.image = image
                        visibleCell.activityIndicator.stopAnimating()
                    }
                }
            }.resume()
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select", indexPath.item)

        let productImageViewController = ProductCardViewController()

        navigationController?.pushViewController(productImageViewController, animated: true)

        let photo = photos[indexPath.item]
        guard let currentUrlString = photo.urlO, let currentUrl = URL(string: currentUrlString) else {
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let imageData = try Data(contentsOf: currentUrl)
                DispatchQueue.main.async {
                    productImageViewController.productImage.image = UIImage(data: imageData)
                }
            } catch {
                print("Failed to load image data:", error.localizedDescription)
            }
        }
    }
}
