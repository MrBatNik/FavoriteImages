//
//  CustomButton.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 04.05.2023.
//

import UIKit

final class CustomButton: UIButton {
    
    private let cornerRadius: CGFloat = 10
    private let color: UIColor = .systemBlue
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = color
        layer.cornerRadius = cornerRadius
    }
    
}
