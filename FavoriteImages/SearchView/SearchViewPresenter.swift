//
//  SearchViewPresenter.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 05.05.2023.
//

import Foundation

protocol SearchViewPresentationLogic {
    var viewController: SearchViewLogic? { get set }
    
    func initialSetup()
    func onQueryButtonTap(_ image: String?)
    func onFavoriteButtonTap()
}

final class SearchViewPresenter: SearchViewPresentationLogic {
    
    weak var viewController: SearchViewLogic?
    
    func initialSetup() {
        viewController?.initialSetup()
    }
    
    func onQueryButtonTap(_ image: String?) {
        guard let image else { return }
        NetworkManager.fetch(image.parameters()) { [weak self] in
            switch $0 {
            case .success(let data):
                self?.viewController?.onQueryButtonTap(data)
            case .failure(let error as NetworkError):
                self?.viewController?.presentError(message: error.rawValue)
            case .failure(let error):
                self?.viewController?.presentError(message: error.localizedDescription)
            }
        }
    }
    
    func onFavoriteButtonTap() {
        
    }
    
}
