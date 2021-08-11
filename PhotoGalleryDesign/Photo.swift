//
//  Photo.swift
//  PhotoGalleryDesign
//
//  Created by Nazario Mariano on 8/11/21.
//

import Foundation

struct Photo: Codable {
    let description: String?
    let urls: Url
    let user: User
}

struct Url: Codable {
    let regular: String
}

struct User: Codable {
    let name: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case name, profileImage = "profile_image"
    }
}

struct ProfileImage: Codable {
    let medium: String
}
