//
//  ViewController.swift
//  PhotoGalleryDesign
//
//  Created by Nazario Mariano on 8/11/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = APIClient()
        client.fetch(resource: "photos") { data, _, _ in
            print(data as Any)
        }
    }


}

