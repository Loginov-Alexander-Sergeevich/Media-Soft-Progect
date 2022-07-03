//
//  TabBarViewController.swift
//  MediaSoftProgect
//
//  Created by Александр Логинов on 01.07.2022.
//

// ПРОЕКТ БЫЛ НАПИСАН ЗА 3 ДНЯ, ТАК КАК ПРИСОЕДИНИЛСЯ ПОЗДНО К КУРСУ!
// Есть баги и не доделки
// Регистрацию и автоизацию реализовал через Firebase, так как уже не успевал


import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
    
        let posterViewController = PosterViewController()
        let favoritePosterViewController = FavoritePosterViewController()
        
        let weightConfigImage = UIImage.SymbolConfiguration(weight: .heavy)
        
        let searchPhotosImage = UIImage(systemName: "heart", withConfiguration: weightConfigImage)!
        searchPhotosImage.withTintColor(.red)
        let favoritePhotosImage = UIImage(systemName: "heart.fill", withConfiguration: weightConfigImage)!
        favoritePhotosImage.withTintColor(.red)
        
        viewControllers = [
            generateNavigatonController(posterViewController, "Posters", searchPhotosImage),
            generateNavigatonController(favoritePosterViewController, "Favourite posters", favoritePhotosImage)
        ]
        
        setTabBar()
    }
    
    private func setTabBar() {
        self.tabBar.layer.masksToBounds = true
        self.tabBar.barStyle = .black
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor.systemRed
        
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.shadowOpacity = 1
        self.tabBar.layer.masksToBounds = false
    }
    
    private func generateNavigatonController(_ rootViewController: UIViewController, _ title: String, _ image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
