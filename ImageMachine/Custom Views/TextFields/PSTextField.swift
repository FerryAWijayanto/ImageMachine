//
//  PSTextField.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit

class PSTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y + 8, width: bounds.size.width - 20, height: bounds.size.height - 16)
     }

     override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return self.textRect(forBounds: bounds)
     }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholderName: String) {
        self.init(frame: .zero)
        placeholder = placeholderName
        
    }
    
    private func configure() {
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        layer.cornerRadius = 6
    }

}
