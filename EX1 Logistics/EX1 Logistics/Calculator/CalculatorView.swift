//
//  CalculatorView.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/6/26.
//

import UIKit

class CalculatorView: UIViewController {
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        view.addSubview(calculatorLabel)
        view.addSubview(tableForCalculator)
        view.addSubview(blueView)
        blueView.addSubview(whiteView)
        whiteView.addSubview(totalPriceLabel)
        view.addSubview(totalPriceButton)
        
        setupConstraints()
    }
    
    //Заголовок сверху слева
    let calculatorLabel = CalculatorLabel().calculatorLabel
    
    //Поле для вывода итоговой стоимости
    let whiteView = TotalPriceView().whiteView
    let blueView = TotalPriceView().blueView
    let totalPriceLabel = TotalPriceView().totalPrice
    
    //Кнопка для расчета стоимости
    var totalPriceButton = TotalPriceButton().totalPriceButton
    
    //Таблица
    let tableForCalculator = TableForCalculator()
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            //Заголовок сверху слева
            calculatorLabel.topAnchor.constraint(equalTo: view.topAnchor,
                                                 constant: 75),
            calculatorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                     constant: 15),
            
            //Таблица
            tableForCalculator.topAnchor.constraint(equalTo: calculatorLabel.bottomAnchor,
                                                    constant: 40),
            tableForCalculator.leadingAnchor.constraint(equalTo: calculatorLabel.leadingAnchor,
                                                       constant: 5),
            tableForCalculator.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                         constant: -25),
            tableForCalculator.bottomAnchor.constraint(equalTo: blueView.topAnchor,
                                                       constant: -20),
            //Поле для вывода итоговой стоимости
            blueView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -350),
            blueView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            blueView.trailingAnchor.constraint(equalTo: tableForCalculator.trailingAnchor, constant: 0),
            blueView.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            
            whiteView.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 2),
            whiteView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: -2),
            whiteView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 2),
            whiteView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -2),
            
            totalPriceLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 0),
            totalPriceLabel.bottomAnchor.constraint(equalTo: whiteView.bottomAnchor, constant: 0),
            totalPriceLabel.trailingAnchor.constraint(equalTo: whiteView.trailingAnchor, constant: -5),
            
            //Кнопка для расчета стоимости
            totalPriceButton.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 0),
            totalPriceButton.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 0),
            totalPriceButton.trailingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: -15),
            totalPriceLabel.centerYAnchor.constraint(equalTo: blueView.centerYAnchor, constant: 0)
        ])
    }
}
