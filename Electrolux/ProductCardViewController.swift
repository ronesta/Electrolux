//
//  ProductCardViewController.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 18.08.2024.
//

import UIKit

final class ProductCardViewController: UIViewController {
    var productImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.addSubview(productImage)
        view.backgroundColor = .systemGray5

        productImage.contentMode = .scaleAspectFit
        productImage.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        productImage.autoPinEdge(toSuperviewSafeArea: .top)
    }
}
