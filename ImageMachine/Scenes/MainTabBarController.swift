//
//  MainTabBarController.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let store: MachineStore
    
    init(store: MachineStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let machineVC = MachineDataVC()
        machineVC.store = store
        let machineDataVC = UINavigationController(rootViewController: machineVC)
        machineDataVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let codeReaderVC = UINavigationController(rootViewController: CodeReaderVC())
        codeReaderVC.tabBarItem = UITabBarItem(title: "QR Reader", image: UIImage(systemName: "qrcode"), tag: 1)

        viewControllers = [
            machineDataVC,
            codeReaderVC
        ]
    }
    
}
