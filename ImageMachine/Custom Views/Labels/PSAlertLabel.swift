//
//  PSAlertLabel.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import UIKit

class PSAlertLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(textLabel: String, textAlignment: NSTextAlignment = .natural, fontSize: CGFloat = 13) {
        self.init(frame: .zero)
        self.text = textLabel
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
