//
//  TotalPriceButton.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/9/26.
//

import UIKit

class TotalPriceButton: UIView {
    
    var data: DataPickerBasis?
    var result: Double?
    
    var totalPriceButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.addTarget(TotalPriceButton.self, action: #selector(calc), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let config = UIImage.SymbolConfiguration(weight: .bold)
        button.setImage(UIImage(systemName: "wand.and.sparkles", withConfiguration: config), for: .normal)
        button.tintColor = .systemBlue
        
        return button
    }()
    
    @objc func calc() {
        let result = 10 + 50
    }
}
