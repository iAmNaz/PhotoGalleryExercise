//
//  ViewController.swift
//  PhotoGalleryDesign
//
//  Created by Nazario Mariano on 8/11/21.
//

import UIKit

class GalleryViewController: UIViewController {
    let screenSize = UIScreen.main.bounds
    
    @IBOutlet var collectionView: UICollectionView!
    private var photos = [Photo]()

    fileprivate func loadPhotos() {
        let client = UnsplashAPI()
        client.getPhotos { (photos: [Photo]?, error: PhotoAPIError?) in
            DispatchQueue.main.async {
                if let error = error {
                    // show alert
                    print(error)
                    
                    switch error {
                    case .apiFailed(let message):
                        print(message)
                    case .parsingFailed(let message):
                        print(message)
                    }
                } else {
                    if let photos = photos {
                        self.photos = photos
                    } else {
                        self.photos = [Photo]()
                    }
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadPhotos()
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.row]
        cell.photo = photo
        return cell
    }
    
    
    
}

extension GalleryViewController: UICollectionViewDelegate {

}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.width, height: 280)
    }
}
