//
//  TabBarViewController.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 04.05.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupViewControllers()
    }

}

private extension TabBarViewController {
    
    func setup() {
        view.backgroundColor = .white
    }
    
    func setupViewControllers() {
        viewControllers = [
            createNavigationController(for: SearchViewController(),
                                       title: "Search",
                                       image: UIImage(named: "magnifyingglass.circle")),
            createNavigationController(for: FavoriteViewController(),
                                       title: "Favorite",
                                       image: UIImage(named: "star.circle")),
        ]
    }
    
    func createNavigationController(for rootViewController: UIViewController,
                                    title: String,
                                    image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        
        return navigationController
    }
    
}
