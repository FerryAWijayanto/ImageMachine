//
//  PSLabel.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit

class PSLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.text  = text
        font       = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        textColor                                   = .label
        adjustsFontSizeToFitWidth                   = true
        minimumScaleFactor                          = 0.9
        lineBreakMode                               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints   = false
    }

}
