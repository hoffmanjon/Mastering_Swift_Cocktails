//
//  DataController.swift
//  Cocktails
//
//  Created by Jon Hoffman on 6/14/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Cocktails")
    init(inMemory: Bool = false) {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
