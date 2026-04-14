//
//  TableForCalculator.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/7/26.
//

import UIKit

class TableForCalculator: UITableView {
    
    lazy var dataFromTo = [
        DataFromTo(nameForCell: "Город отправления",
                   imageForCell: UIImage(systemName: "airplane.departure")),
        DataFromTo(nameForCell: "Город назначения",
                  imageForCell: UIImage(systemName: "airplane.arrival"))
    ]
    
    lazy var dataForBasis = [
        DataBasis(nameForCell: "Условие поставки Incoterms",
                  imageForCell: UIImage(systemName: "tachometer"))
    ]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        translatesAutoresizingMaskIntoConstraints = false
        dataSource = self
        register(CellsFromTo.self, forCellReuseIdentifier: CellsFromTo.reuseID)
        register(CellForBasis.self, forCellReuseIdentifier: CellForBasis.reuseID)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableForCalculator: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataFromTo.count + dataForBasis.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 || indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CellsFromTo.reuseID, for: indexPath)
            as! CellsFromTo
            
            let cellFromTo = dataFromTo[indexPath.row]
            cell.setupCell(post: cellFromTo)
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: CellForBasis.reuseID,for: indexPath)
            as! CellForBasis
            
            let cellForBasis = dataForBasis[indexPath.row - 2]
            cell.setupCell(post: cellForBasis)
            return cell
        }
    }
}

