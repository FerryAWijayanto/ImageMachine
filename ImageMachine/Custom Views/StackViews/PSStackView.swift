//
//  PSStackView.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import UIKit

class PSStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        axis = .vertical
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = false
    }

}
