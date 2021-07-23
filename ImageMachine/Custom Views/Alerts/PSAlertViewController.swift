//
//  PSAlertViewController.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import UIKit

class PSAlertViewController: UIViewController {

    let containerView   = PSContainerView()
    let titleLabel      = PSTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel    = PSBodyLbl(textAlignment: .center)
    let calloutButton   = PSCalloutBtn(label: "OK", bgColor: .systemBlue)
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        setupContainerView()
        setupTitleLabel()
        setupCalloutButton()
        setupMessageLabel()
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 240),
            containerView.widthAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    private func setupTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text     = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func setupMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text           = message ?? "Unable to complete requests"
        messageLabel.numberOfLines  = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: calloutButton.topAnchor, constant: -12)
        ])
    }
    
    private func setupCalloutButton() {
        containerView.addSubview(calloutButton)
        calloutButton.setTitle(buttonTitle ?? "Dismiss", for: .normal)
        calloutButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            calloutButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            calloutButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            calloutButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            calloutButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func dismissVC() {
        dismiss(animated: true, completion: nil)
    }
}
