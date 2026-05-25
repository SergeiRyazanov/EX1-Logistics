//
//  File.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/8/26.
//

import UIKit

struct BasisResponse: Codable {
    
    let basis: [BasisItem]
}

struct BasisItem: Codable {
    
    let id: String
    let name: String
    let weight: Int
}

// MARK: - Модель для Picker
struct DataPickerBasis {
    
    let id: String
    let type: String
    let price: Int
}

class PickerWithBasis: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    lazy var pickerForBasis: [DataPickerBasis] = []
    
    var tapCellBasisHandler: ((String, String) -> Void)?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
        sizeToFit()
        
        fetchBasis()
    }
    
    // MARK: - Получение basis с API
    private func fetchBasis() {
        
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
                let decodedData = try JSONDecoder().decode(BasisResponse.self, from: data)
                
                // MARK: - Преобразуем данные API в массив Picker
                let basisArray = decodedData.basis.map {
                    
                    DataPickerBasis(
                        id: $0.id,
                        type: $0.name,
                        price: $0.weight
                    )
                }
                
                DispatchQueue.main.async {
                    
                    // Обновляем данные picker
                    self?.pickerForBasis = basisArray
                    
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
        
        pickerForBasis.count
    }
    
    // MARK: - Текст строки
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        pickerForBasis[row].type
    }
    
    // MARK: - Выбор строки
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        let selected = pickerForBasis[row]
        
        tapCellBasisHandler?(selected.id, selected.type)
        
        // Можно использовать цену/вес:
        print("Выбран basis:", selected.type)
        print("Weight:", selected.price)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
