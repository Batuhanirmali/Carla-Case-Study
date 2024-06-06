//
//  PhotoTableViewCell.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 6.06.2024.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    var loadingIndicator = UIActivityIndicatorView(style: .medium)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLoadingIndicator()
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: photoImageView.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor)
        ])
    }
    
    func configure(with photo: Photo) {
        cameraLabel.text = photo.camera.fullName
        dateLabel.text = photo.earthDate.formattedDate()
        idLabel.text = "ID: \(photo.id)"

        dateLabel.setInterFont(.light, size: 14)
        cameraLabel.setInterFont(.medium, size: 14)
        idLabel.setInterFont(.medium, size: 14)

        idLabel.textColor = UIColor(hex: "#592626")
        cameraLabel.textColor = UIColor(hex: "#525266")
        dateLabel.textColor = UIColor(hex: "#696984")

        if let photoUrl = URL(string: photo.imgSrc) {
            loadingIndicator.startAnimating()
            photoImageView.sd_setImage(with: photoUrl, placeholderImage: nil, options: [], completed: { [weak self] (image, error, cacheType, imageUrl) in
                self?.loadingIndicator.stopAnimating()
                if error != nil {
                    self?.photoImageView.image = UIImage(named: "notfound")
                }
            })
        } else {
            photoImageView.image = UIImage(named: "notfound")
        }
    }
    
}
