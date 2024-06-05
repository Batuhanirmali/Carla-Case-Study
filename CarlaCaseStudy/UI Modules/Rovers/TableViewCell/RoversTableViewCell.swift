//
//  RoversTableViewCell.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import UIKit

class RoversTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellNameLabel: UILabel!
    @IBOutlet weak var cellLandingDateLabel: UILabel!
    @IBOutlet weak var cellLaunchDateLabel: UILabel!
    @IBOutlet weak var cellStatusLabel: UILabel!
    @IBOutlet weak var cellGoToDetailButton: UIButton!
    @IBOutlet weak var cellFixedLandingDateLabel: UILabel!
    @IBOutlet weak var cellFixedLaunchDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLabels()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupLabels() {
        cellNameLabel.setInterFont(.medium, size: 18)
        cellLaunchDateLabel.setInterFont(.medium, size: 12)
        cellLandingDateLabel.setInterFont(.medium, size: 12)
        cellFixedLandingDateLabel.setInterFont(.regular, size: 14)
        cellFixedLaunchDateLabel.setInterFont(.regular, size: 14)
        cellStatusLabel.setQuicksandFont(.regular, size: 14)
    }
    
}

