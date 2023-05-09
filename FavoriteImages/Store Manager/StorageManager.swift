//
//  StorageManager.swift
//  FavoriteImages
//
//  Created by Nikita Batrakov on 08.05.2023.
//

import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "ImageModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchContext() -> [ImageModel] {
        do {
            return try context.fetch(ImageModel.fetchRequest())
        } catch {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func deleteContext(_ image: ImageModel) {
        context.delete(image)
    }
    
}
