//
//  ViewController.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 14.08.2024.
//

import UIKit
import PureLayout
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupViews()
        setupNavigationBar()
    }

    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()

    func setupNavigationBar() {
        navigationItem.title = "First Tab"
    }

    func setupViews() {
        view.addSubview(searchBar)

        searchBar.autoAlignAxis(toSuperviewAxis: .vertical)
        searchBar.autoPinEdge(toSuperviewSafeArea: .top)
        searchBar.autoPinEdge(toSuperviewEdge: .left)
        searchBar.autoPinEdge(toSuperviewEdge: .right)
    }
}
