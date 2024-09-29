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
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2.5),
                                 height: (UIScreen.main.bounds.width / 2.5)
        )
        layout.minimumLineSpacing = 50
        layout.minimumInteritemSpacing = 50
        layout.sectionInset = UIEdgeInsets(top: 11,
                                           left: 11,
                                           bottom: 10,
                                           right: 11
        )

        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout
        )
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
        photos.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CustomCollectionViewCell.id,
            for: indexPath)
                as? CustomCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let imageURL = photos[indexPath.item].urlO else {
            return cell
        }
        cell.currentImageURL = imageURL
        ImageLoader.shared.loadImage(from: imageURL) { loadedImage in
            DispatchQueue.main.async {
                if cell.currentImageURL == imageURL {
                    cell.configure(with: loadedImage)
                }
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FirstViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Select", indexPath.item)

        guard let currentUrlString = photos[indexPath.item].urlO,
              let currentUrl = URL(string: currentUrlString) else {
            return
        }

        let productImageViewController = ProductCardViewController(imageURL: currentUrl)

        navigationController?.pushViewController(productImageViewController, animated: true)
    }
}
