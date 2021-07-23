//
//  MachineItem.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 22/07/21.
//

import Foundation

struct MachineItem: Codable {
    
    var id = UUID().uuidString
    var name: String
    var type: String
    var qrNumber = Int.random(in: 1..<1000)
    var maintenanceDate: String?
    var images: [Data]?
}
