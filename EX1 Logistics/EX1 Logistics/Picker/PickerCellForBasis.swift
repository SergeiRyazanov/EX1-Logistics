//
//  File.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/8/26.
//

import UIKit

class PickerCellForBasis: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    lazy var pickerForBasis = [
        
        DataPickerBasis(type: "EXW", price: 2),
        DataPickerBasis(type: "FCA", price: 3),
        DataPickerBasis(type: "FAS", price: 4),
        DataPickerBasis(type: "FOB", price: 5),
        DataPickerBasis(type: "CFR", price: 6),
        DataPickerBasis(type: "CIF", price: 7),
        DataPickerBasis(type: "CPT", price: 8),
        DataPickerBasis(type: "CIP", price: 9),
        DataPickerBasis(type: "DPU", price: 10),
        DataPickerBasis(type: "DAP", price: 11),
        DataPickerBasis(type: "DDP", price: 12)
    ]
    
    var tapCellBasisHandler: ((String) -> Void)?

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
        sizeToFit()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        pickerForBasis.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) ->
    String? {
        
        pickerForBasis[row].type
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selected = pickerForBasis[row]
        tapCellBasisHandler?(selected.type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
