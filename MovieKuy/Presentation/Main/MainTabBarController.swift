//
//  ViewController.swift
//  MovieKuy
//
//  Created by Raden Dimas on 21/05/22.
//

import UIKit


final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeViewController = HomeViewController()
        
        homeViewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(
            title: "Browse",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        let favoriteViewController = FavoriteViewController()
        favoriteViewController.tabBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: UIImage(systemName: "person.crop.circle"),
            selectedImage: UIImage(systemName: "play.crop.circle.fill")
        )
        
        let viewControllers: [UINavigationController] = [
            homeViewController,searchViewController,favoriteViewController,profileViewController
        ].map {
            let navigationController = UINavigationController(rootViewController: $0)
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationItem.largeTitleDisplayMode = .always
            navigationController.navigationBar.tintColor = .white
            return navigationController
        }
    
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        self.viewControllers = viewControllers
    }

}

