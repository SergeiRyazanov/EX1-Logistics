//
//  CalculatorView.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/6/26.
//
//
import UIKit

// MARK: - Модель POST запроса
struct CalculateRequest: Codable {

    let departureId: String
    let arrivalId: String
    let basisId: String
    
    enum CodingKeys: String, CodingKey {

        case departureId = "departure_id"
        case arrivalId   = "arrival_id"
        case basisId     = "basis_id"
    }
}

// MARK: - Ответ сервера
struct CalculateResponse: Codable {
    
    let cost: Int
}

class CalculatorView: UIViewController {
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        view.addSubview(calculatorLabel)
        view.addSubview(tableForCalculator)
        tableForCalculator.dataSource = tableForCalculator
        view.addSubview(warningMessage)
        //view.addSubview(totalPriceButton)
        view.addSubview(blueView)
        blueView.addSubview(totalPriceButton)
        
        setupConstraints()
    }
    
    private var departureID: String?
    private var arrivalID: String?
    private var basisID: String?
    
    let calculatorLabel: UILabel = {
        
        $0.text = "Расчёт доставки"
        $0.textColor = .black
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    var warningMessage: UILabel = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return $0
    }(UILabel())

    
    let totalPriceButton: UIButton = {
        
        $0.addTarget(self, action: #selector(calc), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Посчитать", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return $0
    }(UIButton())
    
    let blueView: UIView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    // MARK: - Отправка POST запроса
    @objc func calc() {

        // получаем ячейки
        guard
            let fromCell = tableForCalculator.cellForRow(at: IndexPath(row: 0, section: 0)) as? CellsFromTo,
            let toCell = tableForCalculator.cellForRow(at: IndexPath(row: 1, section: 0)) as? CellsFromTo,
            let basisCell = tableForCalculator.cellForRow(at: IndexPath(row: 2, section: 0)) as? CellForBasis,
            let departureID = fromCell.selectedCityID,
            let arrivalID = toCell.selectedCityID,
            let basisID = basisCell.selectedBasisID
        else {
            warningMessage.text = "Заполните все поля!"
            return
        }

        let requestModel = CalculateRequest(
            departureId: departureID,
            arrivalId: arrivalID,
            basisId: basisID
        )

        guard let url = URL(string: "https://test.ex1calcdata.ru/calculate") else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONEncoder().encode(requestModel)
        } catch {
            print("Ошибка кодирования:", error)
            return
        }
                        
        URLSession.shared.dataTask(with: request) { [weak self] data, _, error in

            if let error = error {
                print("Ошибка запроса:", error)
                return
            }

            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(CalculateResponse.self, from: data)

                DispatchQueue.main.async {
                                        
                    let emailVC = EmailView()
                    emailVC.cost = response.cost
                    emailVC.cityFrom = fromCell.selectedText
                    emailVC.cityTo = toCell.selectedText
                    emailVC.basis = basisCell.selectedText

                    self?.present(emailVC, animated: true)

                }

            } catch {
                print("Ошибка декодирования:", error)
            }

        }.resume()
    }
    
    let tableForCalculator = TableForCalculator()
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            calculatorLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75),
            calculatorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            
            tableForCalculator.topAnchor.constraint(equalTo: calculatorLabel.bottomAnchor, constant: 40),
            tableForCalculator.leadingAnchor.constraint(equalTo: calculatorLabel.leadingAnchor, constant: 5),
            tableForCalculator.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            tableForCalculator.bottomAnchor.constraint(equalTo: warningMessage.topAnchor, constant: 0),
            
            warningMessage.centerXAnchor.constraint(equalTo: tableForCalculator.centerXAnchor, constant: 0),
            warningMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            warningMessage.bottomAnchor.constraint(equalTo: totalPriceButton.topAnchor, constant: 0),

            totalPriceButton.topAnchor.constraint(equalTo: tableForCalculator.bottomAnchor, constant: 60),
            totalPriceButton.centerXAnchor.constraint(equalTo: warningMessage.centerXAnchor),
            
            blueView.topAnchor.constraint(equalTo: totalPriceButton.topAnchor, constant: -5),
            blueView.bottomAnchor.constraint(equalTo: totalPriceButton.bottomAnchor, constant: 5),
            blueView.leadingAnchor.constraint(equalTo: totalPriceButton.leadingAnchor, constant: -10),
            blueView.trailingAnchor.constraint(equalTo: totalPriceButton.trailingAnchor, constant: 10),

        ])
    }
}
