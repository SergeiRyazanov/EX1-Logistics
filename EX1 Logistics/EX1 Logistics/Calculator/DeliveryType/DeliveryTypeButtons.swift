//
//  DeliveryTypeButtons.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/14/26.
//

import UIKit

class DeliveryTypeButtons {
    
    let backColor: UIView = {
        
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        return view
    }()
    
    let deliveryBoxButton: UIButton = {
        
        let boxButton = UIButton()
        return boxButton
    }()
    
    let deliveryConteinerButton: UIButton = {
        
        let conteinerButton = UIButton()
        return conteinerButton
    }()
}
