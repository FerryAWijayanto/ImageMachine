//
//  PSAlertImageVC.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 24/07/21.
//

import UIKit

class PSAlertImageVC: UIViewController {
    
    let dismissView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9803921569, green: 0.9803921569, blue: 0.9803921569, alpha: 1)
        v.layer.cornerRadius = 6
        return v
    }()
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    var pointOrigin: CGPoint?
    
    var image: UIImage?
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeDismiss))
        view.addGestureRecognizer(swipeGesture)
        
        pointOrigin = view.frame.origin
        photoImageView.image = image
        configure()
    }
    
    @objc private func swipeDismiss(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        guard translation.y >= 0 else { return }
        
        view.frame.origin = CGPoint(x: 0, y: pointOrigin!.y + translation.y)
        if gesture.state == .ended {
            let dragVelocity = gesture.velocity(in: view)
            if dragVelocity.y >= 120 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }

}

private extension PSAlertImageVC {
    func configure() {
        [dismissView, photoImageView].forEach({ v in
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        })
        
        NSLayoutConstraint.activate([
            dismissView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            dismissView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            dismissView.heightAnchor.constraint(equalToConstant: 8),
            dismissView.widthAnchor.constraint(equalToConstant: 110),
            
            photoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            photoImageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            photoImageView.heightAnchor.constraint(equalToConstant: view.frame.height / 1.5),
            photoImageView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
    }
}
