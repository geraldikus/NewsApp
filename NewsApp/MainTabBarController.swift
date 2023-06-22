//
//  ViewController.swift
//  NewsApp
//
//  Created by Anton on 20.06.23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        configureTabBar()
    }

    func generateTabBar() {
        let homeViewController = HomeViewController()
        let personalViewController = PersonalViewController()
        let settingsViewController = SettingsViewController()
        
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let personalNavigationController = UINavigationController(rootViewController: personalViewController)
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        
        homeNavigationController.tabBarItem = UITabBarItem(title: "Main News", image: UIImage(systemName: "newspaper"), tag: 0)
        personalNavigationController.tabBarItem = UITabBarItem(title: "Personal Info", image: UIImage(systemName: "person.fill"), tag: 1)
        settingsNavigationController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "slider.horizontal.3"), tag: 2)
        
        viewControllers = [homeNavigationController, personalNavigationController, settingsNavigationController]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func configureTabBar() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let tabBarHeight = min(height, tabBar.bounds.height + positionOnY * 2)
        
        tabBar.itemPositioning = .centered
        let numberOfItems = CGFloat(tabBar.items?.count ?? 1)
        
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
