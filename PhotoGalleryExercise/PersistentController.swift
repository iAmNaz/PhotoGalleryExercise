//
//  PersistentController.swift
//  PhotoGalleryExercise
//
//  Created by Nazario Mariano on 8/13/21.
//

import CoreData

class PersistentController {
    static let shared = PersistentController()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotoGallery")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        print(container.persistentStoreDescriptions.first?.url as Any)
        return container
    }()

    let privateContext: NSManagedObjectContext!
    
    init() {
        privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // argument name/parameter name
    func insert(_ photo: Photo) {
        let context = persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "UserModel", in: context)
        let userModel = UserModel(entity: userEntity!, insertInto: context)
        
        userModel.name = photo.user.name
        userModel.profileImage = photo.user.profileImage.medium
        
        let photoEntity = NSEntityDescription.entity(forEntityName: "PhotoModel", in: context)
        let photoModel = PhotoModel(entity: photoEntity!, insertInto: context)
        photoModel.url = photo.urls.regular
        photoModel.desc = photo.description
        
        //set relationship
        photoModel.user = userModel
        userModel.photo = photoModel
        
        saveContext()
    }
    
    func truncate(entityName: String) {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetch)

        do {
            _ = try persistentContainer.viewContext.execute(deleteRequest)
        } catch {
            fatalError("Failed to execute request: \(error)")
        }
    }
}

let DB = PersistentController.shared
