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
    
    var presenter: SearchViewPresentationLogic?
    
    init(presenter: SearchViewPresentationLogic) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = SearchView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewController = self
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
