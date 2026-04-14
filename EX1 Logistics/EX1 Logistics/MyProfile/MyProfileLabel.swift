//
//  MyProfileLabel.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/7/26.
//

import UIKit

class MyProfileLabel: UILabel {
    
    var myProfileLabel: UILabel {
        
        let label = UILabel()
        label.text = "Мой профиль"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
