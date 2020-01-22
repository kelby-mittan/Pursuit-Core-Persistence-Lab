//
//  ViewController.swift
//  PersistencePixabayLab
//
//  Created by Kelby Mittan on 1/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class PixSearchController: UIViewController {

    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    
    var pixPics = [PixImage]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var searchQuery = "" {
        didSet {
            DispatchQueue.main.async {
                self.loadPix(for: self.searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        loadPix(for: searchQuery)
    }

    private func loadPix(for search: String) {
        
        PixAPIClient.getPix(for: search) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "\(appError)")
                }
            case .success(let pics):
                DispatchQueue.main.async {
                    self?.pixPics = pics
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let cell = sender as? UICollectionViewCell, let pixVC = segue.destination as? PixDetailController, let indexPath = collectionView.indexPath(for: cell) else {
            fatalError("could not load")
        }
        
        pixVC.pixImage = pixPics[indexPath.row]
    }

}

extension PixSearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pixPics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pixCell", for: indexPath) as? PixCollectionCell else {
            fatalError("could not downcast country")
        }
        let pixPic = pixPics[indexPath.row]
        cell.configureCell(for: pixPic)
        
        return cell
    }
}

extension PixSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let interItemSpacing: CGFloat = 4   // space between items
        let maxWidth = UIScreen.main.bounds.size.width  // device's width
        let numberOfItems: CGFloat = 2
        let totalSpacing: CGFloat = numberOfItems * interItemSpacing
        let itemWidth: CGFloat = (maxWidth - totalSpacing) / numberOfItems
        let itemHeight: CGFloat = itemWidth //+ (itemWidth * 0.25)
        
//        return CGSize(width: itemWidth, height: (itemWidth * 2))
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}


extension PixSearchController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
        guard let searchText = searchBar.text else {
            return
        }
        searchQuery = searchText
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            loadPix(for: searchQuery)
            return
        }
        
        searchQuery = searchText
    }
}

