//
//  MainTabBarController.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createViewControllers(vc: MachineDataVC(), title: "Home", imageString: "house", tag: 0),
            createViewControllers(vc: CodeReaderVC(), title: "QR Reader", imageString: "qrcode", tag: 1)
        ]
    }
    
}

private extension MainTabBarController {
    func createViewControllers(vc: UIViewController, title: String, imageString: String, tag: Int) -> UINavigationController {
        let vc = UINavigationController(rootViewController: vc)
        let image = UIImage(systemName: imageString)
        vc.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        
        return vc
    }
}
