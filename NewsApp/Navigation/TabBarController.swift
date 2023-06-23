//
//  ViewController.swift
//  NewsApp
//
//  Created by Anton on 20.06.23.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        configureTabBar()
    }

    func generateTabBar() {
        let homeViewController = MainViewController()
        let personalViewController = SportViewController()
        let settingsViewController = BusinessViewController()
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let personalNavigationController = UINavigationController(rootViewController: personalViewController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        
        homeNavigationController.tabBarItem = UITabBarItem(title: "Main News", image: UIImage(systemName: "newspaper"), tag: 0)
        personalNavigationController.tabBarItem = UITabBarItem(title: "Sport", image: UIImage(systemName: "figure.hockey"), tag: 1)
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Business", image: UIImage(systemName: "suitcase"), tag: 2)
        
        viewControllers = [homeNavigationController, personalNavigationController, settingsNavigationController]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func configureTabBar() {
        let positionOnX: CGFloat = 10
        let width = tabBar.bounds.width - positionOnX * 2
        let numberOfItems = CGFloat(tabBar.items?.count ?? 1)
        
        tabBar.itemPositioning = .centered
        tabBar.itemWidth = width / max(numberOfItems, 1)
        tabBar.barTintColor = UIColor.systemBackground
        tabBar.isTranslucent = false
        tabBar.backgroundColor = UIColor.systemBackground
        
        updateTabBarColors()
    }
    
    private func updateTabBarColors() {
        if traitCollection.userInterfaceStyle == .dark {
            tabBar.tintColor = UIColor.tabBarItemAccentDark
            tabBar.unselectedItemTintColor = UIColor.tabBarItemUnselectedDark
        } else {
            tabBar.tintColor = UIColor.tabBarItemAccentWhite
            tabBar.unselectedItemTintColor = UIColor.tabBarItemUnselectedWhite
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
            updateTabBarColors()
        }
    }
}
