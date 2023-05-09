//
//  FavoriteViewPresenter.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 08.05.2023.
//

import Foundation

protocol FavoriteViewPresentationLogic {
    var viewController: FavoriteViewLogic? { get set }
    
    func initialViewSetup()
    func fetchData()
}

final class FavoriteViewPresenter: FavoriteViewPresentationLogic {
    
    weak var viewController: FavoriteViewLogic?
    
    func initialViewSetup() {
        viewController?.initialViewSetup()
    }
    
    func fetchData() {
        viewController?.present(StorageManager.shared.fetchContext())
    }
    
}
