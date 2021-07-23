//
//  MachineCell.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import UIKit

class MachineCell: UITableViewCell {
    
    static let cellID = "MachineCell"
    
    let machineName: UILabel = {
        let label = UILabel()
        label.text = "Some Machine"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    let machineType: UILabel = {
        let label = UILabel()
        label.text = "Some Type"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .systemGray
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(item: MachineItem) {
        machineName.text = item.name
        machineType.text = item.type
    }
    
}

// MARK: SetupView
private extension MachineCell {
    private func configure() {
        let stackView = UIStackView(arrangedSubviews: [machineName, machineType])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -32),
            stackView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
