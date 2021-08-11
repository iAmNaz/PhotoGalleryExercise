//
//  PhotoCollectionViewCell.swift
//  PhotoGalleryDesign
//
//  Created by Nazario Mariano on 8/11/21.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    static let identifier = "PhotoCollectionViewCell"
    
    var photo: Photo! {
        didSet {
            self.descriptionLabel.text = photo.description ?? "..."
        }
    }
}
