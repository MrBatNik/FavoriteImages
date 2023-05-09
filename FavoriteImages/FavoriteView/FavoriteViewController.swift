//
//  FavoriteViewController.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 04.05.2023.
//

import UIKit

protocol FavoriteViewLogic: AnyObject {
    func initialViewSetup()
    func present(_ data: [ImageModel])
}

final class FavoriteViewController: UIViewController, FavoriteViewLogic {
    
    private var tableView: UITableView!
    private var placeholder: UILabel!
    
    private var presenter: FavoriteViewPresenter?
    
    private let cellIdentifier: String = "favoriteCell"
    private var data: [ImageModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        builder()
        presenter?.initialViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchData()
    }
    
    func initialViewSetup() {
        setupTableView()
        setupPlaceholder()
    }
    
    func present(_ data: [ImageModel]) {
        self.data = data
        placeholder.isHidden = !data.isEmpty
        tableView.reloadData()
    }
    
    private func builder() {
        presenter = FavoriteViewPresenter()
        presenter?.viewController = self
    }
    
    private func setupPlaceholder() {
        placeholder = UILabel()
        placeholder.text = "No images yet"
        placeholder.textAlignment = .center
        placeholder.frame = view.bounds
        
        view.addSubview(placeholder)
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.frame = view.bounds
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        view.addSubview(tableView)
    }

}

extension FavoriteViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        cell.imageView?.image = UIImage(data: data[indexPath.row].imageData ?? .init())
        cell.textLabel?.text = data[indexPath.row].imageURL
        
        return cell
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let imageData = data[indexPath.row]
            StorageManager.shared.deleteContext(imageData)
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            StorageManager.shared.saveContext()
        }
        
        placeholder.isHidden = !data.isEmpty
    }
    
}
