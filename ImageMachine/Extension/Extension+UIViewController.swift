//
//  Extension+UIViewController.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import UIKit

extension UIViewController {
    func presentOAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        let alert                       = PSAlertViewController(title: title, message: message, buttonTitle: buttonTitle)
        alert.modalPresentationStyle    = .overFullScreen
        alert.modalTransitionStyle      = .crossDissolve
        self.present(alert, animated: true)
    }
}
