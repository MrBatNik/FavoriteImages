//
//  UIViewcontroller+Extension.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 08.05.2023.
//

import UIKit

extension UIViewController {
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}
