//
//  MachineUtility.swift
//  ImageMachine
//
//  Created by Ferry Adi Wijayanto on 23/07/21.
//

import Foundation

class MachineUtility {
    
    private static let key = "tasks"
    
    // archive
    private static func archive(_ tasks: [MachineItem]) -> Data? {
        
        return try? NSKeyedArchiver.archivedData(withRootObject: tasks, requiringSecureCoding: false)
    }
    
    // fetch
    static func fetch() -> [MachineItem]? {
        guard let unarchiveData = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        
        return NSKeyedUnarchiver.unarchiveObject(with: unarchiveData) as? [MachineItem]
    }
    
    // save
    static func save(_ tasks: [MachineItem]) {
        // Archive data
        let archiveTask = archive(tasks)
        
        // Set object for key
        UserDefaults.standard.set(archiveTask, forKey: key)
        UserDefaults.standard.synchronize()
    }
}
