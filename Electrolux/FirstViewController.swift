//
//  ViewController.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 14.08.2024.
//

import UIKit
import PureLayout
import SnapKit

class FirstViewController: UIViewController {

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2.5), height: (UIScreen.main.bounds.width / 2.5))
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupViews()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        title = "First Tab"
    }

    func setupViews() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)

        searchBar.autoAlignAxis(toSuperviewAxis: .vertical)
        searchBar.autoPinEdge(toSuperviewSafeArea: .top)
        searchBar.autoPinEdge(toSuperviewEdge: .leading)
        searchBar.autoPinEdge(toSuperviewEdge: .trailing)

        collectionView.autoPinEdge(.top, to: .bottom, of: searchBar)
        collectionView.autoPinEdge(toSuperviewEdge: .leading)
        collectionView.autoPinEdge(toSuperviewEdge: .trailing)
        collectionView.autoPinEdge(toSuperviewSafeArea: .bottom)
    }
}
