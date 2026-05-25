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
        view.addSubview(background)
        view.addSubview(warningText)
        view.addSubview(spinner)
        spinner.startAnimating()
        
        setupConstraints()
    }
   
   //Заголовок сверху слева
    let myProfileLabel: UILabel = {
        
        $0.text = "Мой профиль"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let background: UIView = {
        
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .systemBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    let warningText: UILabel = {
        
        $0.text = "Здесь обязательно что-то будет"
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let spinner: UIActivityIndicatorView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.color = .white
        $0.style = .large
        return $0
    }(UIActivityIndicatorView())
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            myProfileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            myProfileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            background.topAnchor.constraint(equalTo: myProfileLabel.bottomAnchor, constant: 70),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            background.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -180),
            
            warningText.centerXAnchor.constraint(equalTo: background.centerXAnchor, constant: 0),
            warningText.centerYAnchor.constraint(equalTo: background.centerYAnchor, constant: 15),
            
            spinner.centerXAnchor.constraint(equalTo: warningText.centerXAnchor, constant: 0),
            spinner.bottomAnchor.constraint(equalTo: warningText.topAnchor, constant: -10)
        ])
    }
}
