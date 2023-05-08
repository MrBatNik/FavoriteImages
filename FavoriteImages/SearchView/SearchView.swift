//
//  SearchView.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 05.05.2023.
//

import UIKit

final class SearchView: UIView {
    
    var queryAction: (() -> Void)?
    var favoriteAction: (() -> Void)?
    
    private var queryTextField: UITextField!
    private var imageView: UIImageView!
    private var queryButton: UIButton!
    private var favoriteButton: UIButton!
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVStackView()
        setupImageView()
        setupTextField()
        setupQueryButton()
        setupFavoriteButton()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupVStackView() {
        addSubview(stackView)
    }
    
    private func setupImageView() {
        imageView = UIImageView()
        imageView?.image = UIImage(named: "image.placeholder")
        imageView?.clipsToBounds = true
        imageView?.contentMode = .scaleAspectFit
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
    }
    
    private func setupTextField() {
        queryTextField = UITextField()
        queryTextField?.placeholder = "Search..."
        queryTextField?.borderStyle = .roundedRect
        queryTextField?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(queryTextField)
    }
    
    private func setupQueryButton() {
        queryButton = CustomButton(type: .system)
        queryButton?.setTitle("Search", for: .normal)
        queryButton?.setTitleColor(.white, for: .normal)
        queryButton?.addTarget(self, action: #selector(tapQueryButton), for: .touchUpInside)
        
        stackView.addArrangedSubview(queryButton)
    }
    
    private func setupFavoriteButton() {
        favoriteButton = CustomButton(type: .system)
        favoriteButton?.setTitle("Add to favorite", for: .normal)
        favoriteButton?.setTitleColor(.white, for: .normal)
        favoriteButton?.addTarget(self, action: #selector(tapFavoriteButton), for: .touchUpInside)
        
        stackView.addArrangedSubview(favoriteButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            queryTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            queryTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            queryTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func tapQueryButton() {
        queryAction?()
    }
    
    @objc private func tapFavoriteButton() {
        favoriteAction?()
    }
    
}

extension SearchView {
    
    func getQueryURL() -> String? {
        queryTextField?.text
    }
    
    func setImage(_ data: Data) {
        imageView?.image = UIImage(data: data)
    }
    
}
