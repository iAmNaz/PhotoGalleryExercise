//
//  UserModel+CoreDataProperties.swift
//  PhotoGalleryExerciseTests
//
//  Created by Nazario Mariano on 8/12/21.
//
//

import Foundation
import CoreData


extension UserModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserModel> {
        return NSFetchRequest<UserModel>(entityName: "UserModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var profileImage: String?
    @NSManaged public var photo: PhotoModel?

}

extension UserModel : Identifiable {

}
