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
    
    let filterKeywords = ["latest", "oldest", "popular"]
    var currentFilterIndex = 0
    @IBAction func filterChanged(_ sender: Any) {
        let segmentedControl = sender as! UISegmentedControl
        currentFilterIndex = segmentedControl.selectedSegmentIndex
        loadPhotos()
    }
    
    fileprivate func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    fileprivate func loadPhotos() {
        collectionView.isHidden = true
        truncateTables()
        fetchRemoteData()
    }
    
    fileprivate func truncateTables() {
        DB.truncate(entityName: "PhotoModel")
        DB.truncate(entityName: "UserModel")
    }
    
    fileprivate func fetchRemoteData() {
        let client = UnsplashAPI()
        client.getPhotos(orderBy: filterKeywords[currentFilterIndex]) { (photos: [Photo]?, error: PhotoAPIError?) in
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
                            DB.insert(photo)
                        }
                        
                    } else {
                        self.photos = [Photo]()
                    }
                }
                self.collectionView.isHidden = false
                self.collectionView.reloadData()
            }
        }
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
