//
//  PickerWithCities.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 5/11/26.
//

import UIKit

struct CitiesResponse: Codable {
    
    let cities: [CitiesItem]
}

struct CitiesItem: Codable {
    
    let id: String
    let name: String
    let weight: Int
}

struct DataPickerCities {
    
    let id: String
    let type: String
    let price: Int
}

class PickerWithCities: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    lazy var pickerForCities: [DataPickerCities] = []
    
    // передаем и id, и name
    var tapCellCitiesHandler: ((String, String) -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
        sizeToFit()
        
        // MARK: - Загружаем данные после создания Picker
        fetchCities()
    }
    
    // MARK: - Получение basis с API
    private func fetchCities() {
        
        guard let url = URL(string: "https://test.ex1calcdata.ru/options") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                
                print("Ошибка запроса:", error.localizedDescription)
                return
            }
            
            guard let data = data else {
                
                print("Нет данных")
                return
            }
            
            do {
                
                // Декодируем JSON
                let decodedData = try JSONDecoder().decode(CitiesResponse.self, from: data)
                
                // MARK: - Преобразуем API данные
                let citiesArray = decodedData.cities.map {
                    
                    DataPickerCities(
                        id: $0.id,
                        type: $0.name,
                        price: $0.weight
                    )
                }
                
                DispatchQueue.main.async {
                    
                    // Обновляем данные picker
                    self?.pickerForCities = citiesArray
                    
                    // Перезагружаем picker
                    self?.reloadAllComponents()
                }
                
            } catch {
                print("Ошибка декодирования:", error.localizedDescription)
            }
            
        }.resume()
    }
    
    // MARK: - Количество колонок Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    // MARK: - Количество строк
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        pickerForCities.count
    }
    
    // MARK: - Текст строки
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {

        let label = UILabel()
        label.text = "           " + pickerForCities[row].type
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail

        let pickerWidth = pickerView.bounds.width
        let rowHeight = pickerView.rowSize(forComponent: component).height

         //левый край текста = центр picker’а
        label.frame = CGRect(
            x: pickerWidth + 15,
            y: 0,
            width: pickerWidth / 2,
            height: rowHeight
        )

        return label
    }
    // MARK: - Выбор строки
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        let selected = pickerForCities[row]
        
        // MARK: - Сохраняем ID выбранного города
        tapCellCitiesHandler?(selected.id, selected.type)
        
        // Можно использовать цену/вес:
        print("Выбран basis:", selected.type)
        print("Weight:", selected.price)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
