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
    func onFavoriteButtonTap(_ text: String?)
}

final class SearchViewPresenter: SearchViewPresentationLogic {
    
    weak var viewController: SearchViewLogic?
    
    private var currentImageData: Data?
    
    func initialSetup() {
        viewController?.initialSetup()
    }
    
    func onQueryButtonTap(_ image: String?) {
        guard let image, !image.isEmpty else {
            viewController?.presentError(message: "Type request text first")
            return
        }
        
        let request = RequestURL.dummy.rawValue + image.parameters()
        
        if isExist(imageURL: request) {
            viewController?.onQueryButtonTap(getData(imageURL: request))
            return
        }
        
        NetworkManager.fetch(image.parameters()) { [weak self] in
            switch $0 {
            case .success(let data):
                self?.currentImageData = data
                self?.viewController?.onQueryButtonTap(data)
            case .failure(let error as NetworkError):
                self?.viewController?.presentError(message: error.rawValue)
            case .failure(let error):
                self?.viewController?.presentError(message: error.localizedDescription)
            }
        }
    }
    
    func onFavoriteButtonTap(_ text: String?) {
        guard let text, let currentImageData else {
            viewController?.presentError(message: "Search for image first")
            return
        }
        
        let request = RequestURL.dummy.rawValue + text.parameters()
        
        if !isExist(imageURL: request) {
            removeImage()
            save(data: currentImageData, for: request)
            self.currentImageData = nil
        } else {
            viewController?.presentError(message: "Image already exists")
        }
        
        viewController?.onFavoriteButtonTap(message: "Added to favorite")
    }
    
    private func isExist(imageURL: String) -> Bool {
        let imagesData = StorageManager.shared.fetchContext()
        return imagesData.contains(where: { $0.imageURL == imageURL })
    }
    
    
    private func save(data: Data, for request: String) {
        let imageModel = ImageModel(context: StorageManager.shared.context)
        
        imageModel.imageData = data
        imageModel.imageURL = request
        
        StorageManager.shared.saveContext()
    }
    
    private func removeImage() {
        let imagesData = StorageManager.shared.fetchContext()
        if imagesData.count > 9, let latestImage = imagesData.first {
            StorageManager.shared.deleteContext(latestImage)
            StorageManager.shared.saveContext()
        }
    }
    
    private func getData(imageURL: String) -> Data {
        let imagesData = StorageManager.shared.fetchContext()
        return imagesData.first(where: { $0.imageURL == imageURL })?.imageData ?? Data()
    }
}
