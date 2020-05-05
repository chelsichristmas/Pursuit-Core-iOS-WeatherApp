//
//  PhotoCell.swift
//  WeatherApp
//
//  Created by Chelsi Christmas on 5/5/20.
//  Copyright © 2020 David Rifkin. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

     
    @IBOutlet weak var photoImageView: UIImageView!
    
    public func configureCell(photo: PhotoDetails) {
        photoImageView.getImage(with: photo.largeImageURL) { (result) in
        switch result {
        case .failure(let appError):
            print("Error getting image: \(appError)")
        case . success(let image):
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }
        
    }

}
}
