//
//  ViewController.swift
//  PhotoGalleryDesign
//
//  Created by Nazario Mariano on 8/11/21.
//

import UIKit
import CoreData

class GalleryViewController: UIViewController {
    let screenSize = UIScreen.main.bounds
    @IBOutlet var collectionView: UICollectionView!
    private var photos = [Photo]()
    let context = appDelegate.persistentContainer.viewContext
    
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
                        
                        for photo in self.photos {
                            let photoEntity = NSEntityDescription.entity(forEntityName: "PhotoModel", in: self.context)
                            let model = PhotoModel(entity: photoEntity!, insertInto: self.context)
                            model.url = photo.urls.regular
                            appDelegate.saveContext()
                        }
                        
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
        self.navigationItem.title = "Gallery"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "toFullScreenImage" else {
            return
        }
        
        let fullScreenVC = segue.destination as! FullScreenImageViewController
        
        guard let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
              let selectedIndexPath = selectedIndexPaths.first else {
            return
        }
        
        let photo = photos[selectedIndexPath.row]
        fullScreenVC.imageUrl = photo.urls.regular
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photo = photos[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
            cell.photo = photo
        
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
}

//let screenSize = UIScreen.main.bounds
extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenSize.size.width, height: 280)
    }
}
