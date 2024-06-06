//
//  RoversTableViewCell.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import UIKit
import SDWebImage

class RoversTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellLandingDateLabel: UILabel!
    @IBOutlet weak var cellLaunchDateLabel: UILabel!
    @IBOutlet weak var cellStatusLabel: UILabel!
    @IBOutlet weak var cellGoToDetailButton: UIButton!
    @IBOutlet weak var cellFixedLandingDateLabel: UILabel!
    @IBOutlet weak var cellFixedLaunchDateLabel: UILabel!
    
    var loadingIndicator = UIActivityIndicatorView(style: .medium)
    var statusLabelWidthConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabels()
        setupLoadingIndicator()
        setupStatusLabelConstraint()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupLabels() {
        cellNameLabel.setInterFont(.medium, size: 18)
        cellLaunchDateLabel.setInterFont(.bold, size: 12)
        cellLandingDateLabel.setInterFont(.bold, size: 12)
        cellFixedLandingDateLabel.setInterFont(.regular, size: 14)
        cellFixedLaunchDateLabel.setInterFont(.regular, size: 14)
        cellStatusLabel.setQuicksandFont(.regular, size: 14)
    }
    
    func setupLoadingIndicator() {
        loadingIndicator.center = cellImageView.center
        cellImageView.addSubview(loadingIndicator)
    }
    
    func setupStatusLabelConstraint() {
        cellStatusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabelWidthConstraint = cellStatusLabel.widthAnchor.constraint(equalToConstant: 50)
        statusLabelWidthConstraint?.isActive = true
    }
    
    func configure(with rover: Rover, photoUrl: String?) {
        cellNameLabel.text = rover.name
        cellLandingDateLabel.text = rover.landingDate.formattedDate()
        cellLaunchDateLabel.text = rover.launchDate.formattedDate()
        
        let status = rover.status.capitalized
        cellStatusLabel.text = status
        
        switch status {
        case "Active":
            cellStatusLabel.backgroundColor = UIColor(hex: "#D5F8E8")
            cellStatusLabel.textColor = UIColor(hex: "#3EAA77")
            cellStatusLabel.layer.borderColor = UIColor(hex: "#3EAA77").cgColor
            cellStatusLabel.layer.borderWidth = 1.0
            cellStatusLabel.layer.cornerRadius = 5.0
            cellStatusLabel.layer.masksToBounds = true
        case "Complete":
            cellStatusLabel.backgroundColor = UIColor(hex: "#006eff")
            cellStatusLabel.textColor = UIColor(hex: "#ffffff")
            cellStatusLabel.layer.borderColor = UIColor(hex: "#0000ff").cgColor
            cellStatusLabel.layer.borderWidth = 1.0
            cellStatusLabel.layer.cornerRadius = 5.0
            cellStatusLabel.layer.masksToBounds = true
            statusLabelWidthConstraint?.constant = 70

        default:
            cellStatusLabel.backgroundColor = UIColor.gray
            cellStatusLabel.textColor = UIColor.white
            cellStatusLabel.layer.borderColor = UIColor.clear.cgColor
            cellStatusLabel.layer.borderWidth = 0.0
        }
        
        if let photoUrl = photoUrl, let url = URL(string: photoUrl) {
            loadingIndicator.startAnimating()
            cellImageView.sd_setImage(with: url, placeholderImage: nil, options: [], completed: { [weak self] (image, error, cacheType, imageUrl) in
                self?.loadingIndicator.stopAnimating()
                if error != nil {
                    self?.cellImageView.image = UIImage(named: "notfound")
                }
            })
        } else {
            cellImageView.image = UIImage(named: "notfound")
        }
    }
}

