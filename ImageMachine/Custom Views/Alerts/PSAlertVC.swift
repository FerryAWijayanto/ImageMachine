//
//  PSAlertVC.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import UIKit

class PSAlertVC: UIViewController {
    
    let containerView   = UIView()
    let addMachineLbl   = PSAlertLabel(textLabel: "Add Machine", textAlignment: .center)
    let nameLabel       = PSLabel(text: "Name", fontSize: 13)
    let nameTextField   = PSTextField(placeholderName: "Name")
    let typeLabel       = PSLabel(text: "Type", fontSize: 13)
    let typeTextField   = PSTextField(placeholderName: "Type")
    let cancelButton    = PSAlertButton(label: "Cancel", bgColor: .systemPink)
    let addButton       = PSAlertButton(label: "Add", bgColor: #colorLiteral(red: 0.9450980392, green: 0.6823529412, blue: 0.3333333333, alpha: 1))
    
    let padding: CGFloat = 16
    
    var closure: ((String, String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        configureContainerView()
        setupViews()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor                           = .systemBackground
        containerView.layer.cornerRadius                        = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    private func setupViews() {
        let nameStackView = PSStackView(arrangedSubviews: [nameLabel, nameTextField])
        let typeStackView = PSStackView(arrangedSubviews: [typeLabel, typeTextField])
        
        addMachineLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        containerView.addSubview(addMachineLbl)
        containerView.addSubview(nameStackView)
        containerView.addSubview(typeStackView)
        containerView.addSubview(cancelButton)
        containerView.addSubview(addButton)
        
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addMachineLbl.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            addMachineLbl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            addMachineLbl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            addMachineLbl.heightAnchor.constraint(equalToConstant: 16),
            
            nameStackView.topAnchor.constraint(equalTo: addMachineLbl.bottomAnchor, constant: padding),
            nameStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            nameStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            nameStackView.heightAnchor.constraint(equalToConstant: 56),
            
            typeStackView.topAnchor.constraint(equalTo: nameStackView.bottomAnchor, constant: padding),
            typeStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            typeStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            typeStackView.heightAnchor.constraint(equalToConstant: 56),
            
            cancelButton.topAnchor.constraint(equalTo: typeStackView.bottomAnchor, constant: 32),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            cancelButton.widthAnchor.constraint(equalToConstant: 120),
            
            addButton.topAnchor.constraint(equalTo: typeStackView.bottomAnchor, constant: 32),
            addButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            addButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            addButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc func addAction() {
        closure?(nameTextField.text ?? "", typeTextField.text ?? "")
        dismiss(animated: true)
    }
    
    @objc func cancelAction() {
        dismiss(animated: true)
    }
}

