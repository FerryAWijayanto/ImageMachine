//
//  MachineStore.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import Foundation

class MachineStore {
    
    var items: [MachineItem] = []
    
    @discardableResult func add(_ machine: MachineItem, at index: Int) -> MachineItem {
        let newMachine = MachineItem(id: machine.id, name: machine.name, type: machine.type, qrNumber: machine.qrNumber, maintenanceDate: machine.maintenanceDate, images: machine.images)
        
        items.insert(newMachine, at: index)
        
        return newMachine
    }
    
    func add(images: Data) {
//        items
    }
    
    func update(_ machine: MachineItem) {
        if let index = items.firstIndex(where: { $0.id == machine.id }) {
            items[index].name = machine.name
            items[index].type = machine.type
            items[index].qrNumber = machine.qrNumber
            items[index].maintenanceDate = machine.maintenanceDate
            items[index].images = machine.images
        }
    }
    
    @discardableResult func remove(at index: Int) -> MachineItem {
        return items.remove(at: index)
    }
}
