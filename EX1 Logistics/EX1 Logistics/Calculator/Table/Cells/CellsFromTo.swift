//
//  CellsFromTo.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/7/26.
//

import UIKit

class CellsFromTo: UITableViewCell {
    
    static var reuseID = "CellsFromTo"
    
    var textInsideCell: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    var imageInsideCell: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
        return $0
    }(UIImageView())
    
    var cellColor: UIView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    func setupCell(post: DataFromTo) {
        
        textInsideCell.text = post.nameForCell
        imageInsideCell.image = post.imageForCell
        cellColor.backgroundColor = .systemBlue
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate ([
            
        contentView.heightAnchor.constraint(equalToConstant: 65),

        imageInsideCell.centerYAnchor.constraint(equalTo: cellColor.centerYAnchor, constant: 0),
        imageInsideCell.leadingAnchor.constraint(equalTo: cellColor.leadingAnchor, constant: 20),
        
        textInsideCell.centerYAnchor.constraint(equalTo: imageInsideCell.centerYAnchor, constant: 0),
        textInsideCell.leadingAnchor.constraint(equalTo: imageInsideCell.trailingAnchor, constant: 15),
        
        cellColor.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
        cellColor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
        cellColor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
        cellColor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
        cellColor.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(cellColor)
        cellColor.addSubview(textInsideCell)
        cellColor.addSubview(imageInsideCell)
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

