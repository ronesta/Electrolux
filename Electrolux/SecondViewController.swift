//
//  SecondViewController.swift
//  Electrolux
//
//  Created by Ибрагим Габибли on 18.08.2024.
//

import UIKit
import PureLayout

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
        productName.font = UIFont.systemFont(ofSize: 20)
        productName.numberOfLines = 0

        return productName
    }()

    private let modelName: UILabel = {
        let modelName = UILabel()
        modelName.text = "Miele Scout RX3"
        modelName.font = UIFont.systemFont(ofSize: 20)
        modelName.numberOfLines = 0

        return modelName
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Описание товара"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        return titleLabel
    }()

    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = descriptionOfProduct
        descriptionLabel.numberOfLines = 0

        return descriptionLabel
    }()

    private let scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }

    private func setupNavigationBar() {
        title = "Second Tab"
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
        scrollView.autoPinEdge(toSuperviewEdge: .leading)
        scrollView.autoPinEdge(toSuperviewEdge: .trailing)
        scrollView.autoPinEdge(toSuperviewSafeArea: .top)
        scrollView.autoPinEdge(toSuperviewSafeArea: .bottom)

        imageView.autoSetDimension(.height, toSize: 200)
        imageView.autoSetDimension(.width, toSize: 200)
        imageView.autoAlignAxis(toSuperviewAxis: .vertical)
        imageView.autoPinEdge(.top, to: .top, of: scrollView, withOffset: 20)

        productName.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 30)
        productName.autoPinEdge(.leading, to: .leading, of: view, withOffset: 45)
        productName.autoPinEdge(.trailing, to: .leading, of: modelName, withOffset: -10)

        modelName.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 30)
        modelName.autoPinEdge(.leading, to: .trailing, of: productName, withOffset: 10)
        modelName.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)

        productName.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        modelName.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        titleLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        titleLabel.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        titleLabel.autoPinEdge(.top, to: .bottom, of: productName, withOffset: 35)

        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 20)
        descriptionLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        descriptionLabel.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        descriptionLabel.autoPinEdge(.bottom, to: .bottom, of: scrollView, withOffset: -20)
    }
}
