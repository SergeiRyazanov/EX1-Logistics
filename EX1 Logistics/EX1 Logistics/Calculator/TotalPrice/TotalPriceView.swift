//
//  TotalPriceView.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/8/26.
//

import UIKit

class TotalPriceView: UIView {
    
    var whiteView: UIView {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 13
        return view
    }
    
    var blueView: UIView {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 15
        return view
    }
    
    var totalPrice: UILabel {
        
        let textField = UILabel()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "...примерная стоимость"
        textField.textAlignment = .right
        textField.textColor = .systemGray
        textField.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return textField
    }
}
