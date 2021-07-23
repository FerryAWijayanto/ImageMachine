//
//  PSContainerView.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import UIKit

class PSContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor                           = .systemBackground
        layer.cornerRadius                        = 16
        layer.borderWidth                         = 2
        layer.borderColor                         = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }

}
