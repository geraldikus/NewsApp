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
        viewControllers = [
        generateVC(
            viewController: HomeViewController(),
            title: "Home",
            image: UIImage(systemName: "house.fill")),
        generateVC(
            viewController: PersonalViewController(),
            title: "Personal Info",
            image: UIImage(systemName: "person.fill")),
        generateVC(
            viewController: SettingsViewController(),
            title: "Settings",
            image: UIImage(systemName: "slider.horizontal.3"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
//    private func configureTabBar() {
//        let positionOnX: CGFloat = 10
//        let positionOnY: CGFloat = 14
//        let width = tabBar.bounds.width - positionOnX * 2
//        let height = tabBar.bounds.width + positionOnY * 2
//
//        let roundLayer = CAShapeLayer()
//
//        let bezierPath = UIBezierPath(roundedRect: CGRect(
//            x: positionOnX,
//            y: tabBar.bounds.minY - positionOnY,
//            width: width,
//            height: height),
//            cornerRadius: height / 8)
//
//        roundLayer.path = bezierPath.cgPath
//
//        tabBar.layer.insertSublayer(roundLayer, at: 0)
//        tabBar.itemWidth = width / 5
//        tabBar.itemPositioning = .centered
//    }
    
//
//    private func configureTabBar() {
//        let positionOnX: CGFloat = 10
//        let positionOnY: CGFloat = 14
//        let width = tabBar.bounds.width - positionOnX * 2
//        let height = tabBar.bounds.height + positionOnY * 2
//
//        let cornerRadius: CGFloat = height / 2 // Установите желаемое значение степени закругления
//
//        let bezierPath = UIBezierPath(roundedRect: CGRect(
//            x: positionOnX,
//            y: tabBar.bounds.origin.y - positionOnY,
//            width: width,
//            height: height),
//            cornerRadius: cornerRadius)
//
//        let roundLayer = CAShapeLayer()
//        roundLayer.path = bezierPath.cgPath
//        roundLayer.fillColor = UIColor.white.cgColor
//        roundLayer.lineWidth = 0
//
//        tabBar.layer.insertSublayer(roundLayer, at: 0)
//
//        tabBar.itemPositioning = .centered
//        tabBar.itemWidth = width / CGFloat(tabBar.items?.count ?? 1)
//    }

    
    private func configureTabBar() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let cornerRadius: CGFloat = height / 2 // Установите желаемое значение степени закругления
        
        let tabBarHeight = min(height, tabBar.bounds.height + positionOnY * 2) // Выберите минимальное значение между вычисленной высотой и текущей высотой TabBar
           
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(
            x: positionOnX,
            y: tabBar.bounds.origin.y - positionOnY,
            width: width,
            height: tabBarHeight),
            cornerRadius: cornerRadius)
        
        let roundLayer = CAShapeLayer()
        roundLayer.path = bezierPath.cgPath
        roundLayer.lineWidth = 0
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemPositioning = .centered
        
        // Установите itemWidth так, чтобы элементы полностью помещались внутри TabBar
        let numberOfItems = CGFloat(tabBar.items?.count ?? 1)
        tabBar.itemWidth = width / max(numberOfItems, 1)
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
        
    }



    


}

