//
//  ViewController.swift
//  EX1 Logistics
//
//  Created by Сергей Рязанов on 5/19/26.
//

import UIKit
import MessageUI

class EmailView: UIViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(emailViewLabel)
        view.addSubview(closeViewButtonTemplate)
        view.addSubview(blueView)
        blueView.addSubview(approximateCostLabel)
        blueView.addSubview(addTextLabel)
        view.addSubview(blueViewForButton)
        blueViewForButton.addSubview(sendMailButton)
        approximateCostLabel.text = "Примерная стоимость доставки: \(cost ?? 0)₽"
        navigationItem.leftBarButtonItem = closeViewButton
        
        setupConstraints()
    }
    
    let blueView: UIView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    let blueViewForButton: UIView = {
        
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 15
        return $0
    }(UIView())
    
    let emailViewLabel: UILabel = {
        
        $0.text = "Заявка на точный расчёт"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    var cost: Int?
    var cityFrom: String?
    var cityTo: String?
    var basis: String?
    
    let approximateCostLabel: UILabel = {
        
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let addTextLabel: UILabel = {
        
        $0.text = """
        Это цифра без учёта типа доставки, типа груза, его габаритов и срочности. 
        
        Для точного расчёта отправьте заявку, нажав кнопку ниже. 
        
        В письме автоматически будут указаны данные, которые вы указали, тема и наш почтовый ящик.
        
        Пожалуйста, добавьте в письмо недосатющие данные из первого предложения. Это поможет быстрее произвести расчёт и связаться с вами. 
        
        Спасибо!
        """
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
  
    lazy var closeViewButton = UIBarButtonItem(customView: closeViewButtonTemplate)

    let closeViewButtonTemplate: UIButton = {
        
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.tintColor = .systemBlue
        $0.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
    
    let sendMailButton: UIButton = {
        
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.titleLabel?.textColor = .white
        $0.setTitle("Отправить заявку", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.addTarget(self, action: #selector(sendMail), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())
        
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            closeViewButtonTemplate.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            closeViewButtonTemplate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            emailViewLabel.topAnchor.constraint(equalTo: closeViewButtonTemplate.topAnchor, constant: 0),
            emailViewLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            
            blueView.topAnchor.constraint(equalTo: emailViewLabel.bottomAnchor, constant: 50),
            blueView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            blueView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            blueView.bottomAnchor.constraint(equalTo: addTextLabel.bottomAnchor, constant: 15),

            approximateCostLabel.topAnchor.constraint(equalTo: blueView.topAnchor, constant: 15),
            approximateCostLabel.leadingAnchor.constraint(equalTo: blueView.leadingAnchor, constant: 25),
            
            addTextLabel.topAnchor.constraint(equalTo: approximateCostLabel.bottomAnchor, constant: 3),
            addTextLabel.leadingAnchor.constraint(equalTo: approximateCostLabel.leadingAnchor, constant: 0),
            addTextLabel.trailingAnchor.constraint(equalTo: blueView.trailingAnchor, constant: -25),
            
            blueViewForButton.topAnchor.constraint(equalTo: blueView.bottomAnchor, constant: 25),
            blueViewForButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blueViewForButton.bottomAnchor.constraint(equalTo: sendMailButton.bottomAnchor, constant: 10),
            blueViewForButton.leadingAnchor.constraint(equalTo: sendMailButton.leadingAnchor, constant: -20),
            blueViewForButton.trailingAnchor.constraint(equalTo: sendMailButton.trailingAnchor, constant: 20),
            
            sendMailButton.centerXAnchor.constraint(equalTo: blueViewForButton.centerXAnchor, constant: 0),
            sendMailButton.centerYAnchor.constraint(equalTo: blueViewForButton.centerYAnchor, constant: 0)
        ])
    }
    
    @objc func closeView() {
        
        dismiss(animated: true)
    }
    
    @objc func sendMail() {
        
        guard MFMailComposeViewController.canSendMail() else {
            print(MFMailComposeViewController.canSendMail())
            return }
        
        let mailVC = MFMailComposeViewController()
        mailVC.mailComposeDelegate = self
        mailVC.setToRecipients(["ryazanovsergei15@gmail.com"])
        mailVC.setSubject("Расчет полной стоимости доставки для *Ваше имя*")
        mailVC.setMessageBody("""
        Добрый день!
        Нужен расчёт доставки с города \(cityFrom ?? "Город не найден") до \(cityTo ?? "Город не найден").
        Условия поставки - \(basis!)
        [Поле для самостоятельного заполнения]
        Спасибо!
        """, isHTML: false)
        
        present(mailVC, animated: true)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {

        controller.dismiss(animated: true)
    }
}
