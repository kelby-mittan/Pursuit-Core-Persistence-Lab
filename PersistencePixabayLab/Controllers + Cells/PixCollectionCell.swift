//
//  PixCollectionCell.swift
//  PersistencePixabayLab
//
//  Created by Kelby Mittan on 1/20/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit
import ImageKit

class PixCollectionCell: UICollectionViewCell {
    
    @IBOutlet var pixabayImage: UIImageView!
    
    func configureCell(for pix: PixImage) {
        pixabayImage.getImage(with: pix.previewURL) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.pixabayImage.image = UIImage(systemName: "photo.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.pixabayImage.image = image
                }
            }
        }
        
    }
    
}
