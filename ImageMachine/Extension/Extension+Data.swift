//
//  Extension+Data.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import UIKit

extension Data {
    var image: UIImage? {
        if let image = UIImage(data: self) {
            return image
        } else {
            return nil
        }
    }
}
