//
//  CoreDataManager.swift
//  GyroData
//
//  Created by 강민수 on 2023/06/15.
//

import CoreData
import Foundation

final class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GyroInfo")
        
        container.loadPersistentStores { desc, error in
            if let error = error {
                fatalError("Unable load persistent stores")
            }
        }
        
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    
    func create(id: UUID, url: URL) {
        let item = GyroInfo(context: context)
        
        item.id = id
        item.url = url
        
        do {
            try context.save()
        } catch {
            return
        }
    }
    
    func read() -> [GyroInfo] {
        let request = GyroInfo.fetchRequest()
        
        do {
            let gyroInfos = try context.fetch(request)
            
            return gyroInfos
        } catch {
            return []
        }
    }
    
    func search(by id: UUID) -> GyroInfo? {
        let request = GyroInfo.fetchRequest()
        
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        guard let searchedData = try? context.fetch(request).first else { return nil }
        
        return searchedData
    }
    
    func delete(id: UUID) {
        let fetchedResult = read()
        
        guard let deletedTarget = fetchedResult.filter({ $0.id == id }).first else { return }
        
        context.delete(deletedTarget)
        
        do {
            try context.save()
        } catch {
            return
        }
    }
}
