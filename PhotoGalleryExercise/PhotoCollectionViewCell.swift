//
//  PhotoCollectionViewCell.swift
//  PhotoGalleryDesign
//
//  Created by Nazario Mariano on 8/11/21.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    static let identifier = "PhotoCollectionViewCell"
    
    var photo: Photo! {
        didSet {
            self.descriptionLabel.text = photo.description ?? "no description"
            
            guard let url = URL(string: photo.urls.regular) else {
                return
            }
            
            self.imageView.kf.setImage(with: url)
        }
    }
}
