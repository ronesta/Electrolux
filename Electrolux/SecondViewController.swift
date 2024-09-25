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
        imageView.image = UIImage(named: "axel")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let firstname: UILabel = {
        let productName = UILabel()
        productName.text = "Axel"
        productName.font = UIFont.systemFont(ofSize: 20)
        productName.numberOfLines = 0
        return productName
    }()

    private let lastname: UILabel = {
        let modelName = UILabel()
        modelName.text = "Wenner-Gren"
        modelName.font = UIFont.systemFont(ofSize: 20)
        modelName.numberOfLines = 0
        return modelName
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "BIO"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        return titleLabel
    }()

    private let biographyLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = biographyText
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
        scrollView.addSubview(firstname)
        scrollView.addSubview(lastname)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(biographyLabel)
    }

    private func setupConstraints() {
        scrollView.autoPinEdge(toSuperviewEdge: .leading)
        scrollView.autoPinEdge(toSuperviewEdge: .trailing)
        scrollView.autoPinEdge(toSuperviewSafeArea: .top)
        scrollView.autoPinEdge(toSuperviewSafeArea: .bottom)

        imageView.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        imageView.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)

        firstname.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        firstname.autoPinEdge(.leading, to: .trailing, of: imageView, withOffset: 20)
        firstname.autoPinEdge(.trailing, to: .trailing, of: imageView, withOffset: 80)

        lastname.autoPinEdge(toSuperviewEdge: .top, withInset: 20)
        lastname.autoPinEdge(.leading, to: .trailing, of: firstname)
        lastname.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -15)

        titleLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: 40)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)

        biographyLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 10)
        biographyLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 20)
        biographyLabel.autoPinEdge(.trailing, to: .trailing, of: view, withOffset: -20)
        biographyLabel.autoPinEdge(.bottom, to: .bottom, of: titleLabel.superview!)
    }
}
