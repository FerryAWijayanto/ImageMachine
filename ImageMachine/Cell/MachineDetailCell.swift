//
//  MachineDetailCell.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit

class MachineDetailCell: UICollectionViewCell {
    static let cellID = "MachineDetailCell"
    
    let machineImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 6
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(imageData: Data) {
        machineImageView.image = imageData.image
    }
    
    private func configure() {
        addSubview(machineImageView)
        machineImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            machineImageView.topAnchor.constraint(equalTo: topAnchor),
            machineImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            machineImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            machineImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
