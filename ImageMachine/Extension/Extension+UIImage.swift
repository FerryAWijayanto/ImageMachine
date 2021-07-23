//
//  Extension+UIImage.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit.UIImage

extension UIImage {

    convenience init?(barcode: String) {
        let data = barcode.data(using: .ascii)
        guard let filter = CIFilter(name: "CICode128BarcodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }
        self.init(ciImage: ciImage)
    }
    
    convenience init?(qrcode: String) {
        let data = qrcode.data(using: .ascii)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setValue(data, forKey: "inputMessage")
        guard let ciImage = filter.outputImage else {
            return nil
        }
        self.init(ciImage: ciImage)
    }
    
    var data: Data? {
            if let data = self.jpegData(compressionQuality: 1.0) {
                return data
            } else {
                return nil
            }
        }

}
