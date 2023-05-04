//
//  SearchViewController.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 04.05.2023.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private var queryTextField: UITextField?
    private var imageView: UIImageView?
    private var queryButton: UIButton?
    private var favoriteButton: UIButton?
    
    private var stackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVStackView()
        setupImageView()
        setupTextField()
        setupQueryButton()
        setupFavoriteButton()
        addConstraints()
    }

}

private extension SearchViewController {
    
    func setupVStackView() {
        view.addSubview(stackView)
    }
    
    func setupImageView() {
        imageView = UIImageView()
        imageView?.image = UIImage(named: "image.placeholder")
        imageView?.frame.size = CGSize(width: 300, height: 300)
        imageView?.clipsToBounds = true
        imageView?.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(imageView ?? .init())
    }
    
    func setupTextField() {
        queryTextField = UITextField()
        queryTextField?.placeholder = "Enter you query"
        queryTextField?.borderStyle = .roundedRect
        
        stackView.addArrangedSubview(queryTextField ?? .init())
    }
    
    func setupQueryButton() {
        queryButton = CustomButton(type: .system)
        queryButton?.setTitle("Query", for: .normal)
        queryButton?.setTitleColor(.white, for: .normal)
        
        stackView.addArrangedSubview(queryButton ?? .init())
    }
    
    func setupFavoriteButton() {
        favoriteButton = CustomButton(type: .system)
        favoriteButton?.setTitle("Favorite", for: .normal)
        favoriteButton?.setTitleColor(.white, for: .normal)
        
        stackView.addArrangedSubview(favoriteButton ?? .init())
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
}
