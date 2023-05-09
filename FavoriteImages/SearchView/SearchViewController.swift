//
//  SearchViewController.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 04.05.2023.
//

import UIKit

protocol SearchViewLogic: AnyObject {
    func initialSetup()
    func onQueryButtonTap(_ data: Data)
    func onFavoriteButtonTap(message: String)
    func presentError(message: String)
}

final class SearchViewController: UIViewController, SearchViewLogic {
    
    private var presenter: SearchViewPresentationLogic?
    
    override func loadView() {
        view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        builder()
        presenter?.initialSetup()
    }
    
    func initialSetup() {
        setupQueryAction()
        setupFavoriteAction()
    }
    
    func onQueryButtonTap(_ data: Data) {
        guard let view = view as? SearchView else { return }
        view.setImage(data)
    }
    
    func onFavoriteButtonTap(message: String) {
        display(message: message)
    }
    
    private func builder() {
        presenter = SearchViewPresenter()
        presenter?.viewController = self
    }
    
    func presentError(message: String) {
        displayError(message: message)
    }
    
    private func setupQueryAction() {
        guard let view = view as? SearchView else { return }
        view.queryAction = {
            self.presenter?.onQueryButtonTap(view.getText())
        }
    }
    
    private func setupFavoriteAction() {
        guard let view = view as? SearchView else { return }
        view.favoriteAction = {
            self.presenter?.onFavoriteButtonTap(view.getText())
        }
    }

}
