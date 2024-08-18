//
//  SecondViewController.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 18.08.2024.
//

import UIKit
import PureLayout
import SnapKit

final class SecondViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "robot")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()

    private let productName: UILabel = {
        let productName = UILabel()
        productName.text = "Робот-пылесос"
        productName.numberOfLines = 0

        return productName
    }()

    private let modelName: UILabel = {
        let modelName = UILabel()
        modelName.text = "Miele Scout RX3"
        modelName.numberOfLines = 0

        return modelName
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Описание товара"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center

        return titleLabel
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = ""
        descriptionLabel.numberOfLines = 0

        return descriptionLabel
    }()

    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubview(scrollView)
        view.backgroundColor = .white
        scrollView.addSubview(imageView)
        scrollView.addSubview(productName)
        scrollView.addSubview(modelName)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(descriptionLabel)
    }

    private func setupConstraints() {
    }
}
