//
//  TabBar.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/7/26.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        tabBar.backgroundColor = .systemBlue
        tabBar.tintColor = .white
        
        setTabs()
        setupTabBarAppearance()
    }
    
    //Настройка самого TabBar
    private func setTabs() {
        
        //Страница с калькулятором
        let mainVC = CalculatorView()
        mainVC.tabBarItem.title = "Калькулятор"
        mainVC.tabBarItem.image = UIImage(systemName: "plus.forwardslash.minus")
        
        //Страница Мой профиль
        let myProfileVC = MyProfileView()
        myProfileVC.tabBarItem.title = "Мой профиль"
        myProfileVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        setViewControllers([mainVC, myProfileVC], animated: false)
    }
    
    //Настройка шрифта в TabBar
    private func setupTabBarAppearance() {
        
        let appearance = UITabBarAppearance()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13, weight: .regular)]
        
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = attributes
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = attributes
        
        tabBar.standardAppearance = appearance
    }
}
