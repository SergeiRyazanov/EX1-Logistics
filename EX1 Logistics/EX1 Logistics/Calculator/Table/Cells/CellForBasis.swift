//
//  CellForBasis.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 4/8/26.
//

import UIKit

class CellForBasis: UITableViewCell {
    
    static var reuseID = "CellForBasis"
    
    let picker = PickerCellForBasis()
    
    var mainToolBar: UIToolbar?
    
    private var selectedText: String?
    
    var textInsideCell: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15)
        $0.textAlignment = .left
        return $0
    }(UITextField())
    
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
    
    func setupCell(post: DataBasis) {
        
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
        textInsideCell.trailingAnchor.constraint(equalTo: cellColor.trailingAnchor, constant: 0),
        
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
        
        textInsideCell.inputView = picker
        
        picker.tapCellBasisHandler = { [weak self] value in
            
            self?.selectedText = value
        }
        
        textInsideCell.inputAccessoryView = createToolBar()
        setupConstraints()
    }
    private func createToolBar() -> UIToolbar {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let flex = UIBarButtonItem(systemItem: .flexibleSpace)
        let done = UIBarButtonItem(title: "Готово",
                                   style: .plain,
                                   target: self,
                                   action: #selector(doneTapped))
        
        toolBar.items = [flex, done, flex]
        return toolBar
    }
    
    @objc private func doneTapped() {
        
        textInsideCell.text = selectedText ?? selectedText
        textInsideCell.resignFirstResponder()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
