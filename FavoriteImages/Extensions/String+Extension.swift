//
//  String+Extension.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 08.05.2023.
//

import Foundation

extension String {
    
    func parameters() -> String {
        self.lowercased().replacingOccurrences(of: ##"\s+"##, with: "+", options: .regularExpression)
    }
    
}
