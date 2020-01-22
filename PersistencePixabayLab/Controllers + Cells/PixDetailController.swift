//
//  PixDetailController.swift
//  PersistencePixabayLab
//
//  Created by Kelby Mittan on 1/21/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class PixDetailController: UIViewController {
    
    @IBOutlet var largePixImage: UIImageView!
    @IBOutlet var tagsLabel: UILabel!
    @IBOutlet var likesLabel: UILabel!
    @IBOutlet var viewsLabel: UILabel!
    @IBOutlet var commentsLabel: UILabel!
    @IBOutlet var postedByLabel: UILabel!
    @IBOutlet var favButton: UIButton!
    
    var pixImage: PixImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    private func updateUI() {
        tagsLabel.text = "Tags: \(pixImage?.tags ?? "")"
        likesLabel.text = "Likes: \(pixImage?.likes.description ?? "")"
        viewsLabel.text = "Views: \(pixImage?.views.description ?? "")"
        commentsLabel.text = "Comments: \(pixImage?.comments.description ?? "")"
        postedByLabel.text = "Posted by: \(pixImage?.user ?? "")"
        
        guard let largeImage = pixImage?.largeImageURL else {
            return
        }
        
        largePixImage.getImage(with: largeImage) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.largePixImage.image = UIImage(systemName: "photo.fill")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.largePixImage.image = image
                }
            }
        }
    }
    
    @IBAction func favButtonPressed(_ sender: UIButton) {
        
        guard let pixImage = pixImage else {
            return
        }
        favButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        favButton.isEnabled = false
        
        do {
            try PersistenceHelper.createImage(image: pixImage)
            showAlert(title: "Cool", message: "This Photo Has Been Favorited")
        } catch {
            print("could not save \(error)")
        }
        
    }
    
}
