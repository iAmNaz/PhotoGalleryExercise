//
//  FullScreenImageViewController.swift
//  PhotoGalleryExercise
//
//  Created by Nazario Mariano on 8/12/21.
//

import UIKit
import Kingfisher

class FullScreenImageViewController: UIViewController {

    var imageUrl: String!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.kf.setImage(with: URL(string: imageUrl))
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
