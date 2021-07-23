//
//  PSCalloutBtn.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import UIKit

class PSCalloutBtn: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(label: String, bgColor: UIColor, fontSize: CGFloat = 14) {
        self.init(frame: .zero)
        
        setTitle(label, for: .normal)
        backgroundColor = bgColor
        titleLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        layer.cornerRadius = 4
        translatesAutoresizingMaskIntoConstraints = false
    }

}
