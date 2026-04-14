//
//  MyProfileView.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/7/26.
//

import UIKit

class MyProfileView: UIViewController {

    override func viewDidLoad() {
        
        view.backgroundColor = .white
        view.addSubview(myProfileLabel)
        
        setupConstraints()
    }
   
   //Заголовок сверху слева
    let myProfileLabel = MyProfileLabel().myProfileLabel
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            //Заголовок сверху слева
            myProfileLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                                 constant: 75),
            myProfileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: 15)
        ])
    }
}
