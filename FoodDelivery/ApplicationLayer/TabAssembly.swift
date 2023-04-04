//
//  TabAssembly.swift
//  FoodDelivery
//
//  Created by Stanislav Lezovsky on 03.04.2023.
//

import UIKit

final class TabAssembly: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createMenuViewController(),
                           createContactViewController(),
                           createProfileViewController(),
                           createCartViewController()]
        
        tabBar.tintColor = Colors.TabBarColors.tabBarTintColor
        tabBar.backgroundColor = Colors.TabBarColors.tabBarBackgroundColor
    }
}

private extension TabAssembly {
    
    func createMenuViewController() -> UIViewController {
        let vc = MenuTabAssembly.build()
        let image = SFSymbols.TabBarSymbols.menuSymbol
        vc.tabBarItem = UITabBarItem(title: "Меню",
                                     image: image,
                                     tag: 0)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createContactViewController() -> UIViewController {
        let vc = UIViewController()
        let image = SFSymbols.TabBarSymbols.contactsSymbol
        vc.tabBarItem = UITabBarItem(title: "Контакты",
                                     image: image,
                                     tag: 1)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createProfileViewController() -> UIViewController {
        let vc = UIViewController()
        let image = SFSymbols.TabBarSymbols.profileSymbol
        vc.tabBarItem = UITabBarItem(title: "Профиль",
                                     image: image,
                                     tag: 2)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createCartViewController() -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        let image = SFSymbols.TabBarSymbols.cartSymbol
        vc.tabBarItem = UITabBarItem(title: "Корзина",
                                     image: image,
                                     tag: 3)
        
        return UINavigationController(rootViewController: vc)
    }
}
