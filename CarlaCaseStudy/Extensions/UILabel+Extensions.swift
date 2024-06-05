//
//  UILabel+Extensions.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 5.06.2024.
//

import UIKit

extension UILabel {
    func setInterFont(_ type: UIFont.InterFont, size: CGFloat) {
        self.font = UIFont.interFont(type, size: size)
    }

    func setQuicksandFont(_ type: UIFont.QuicksandFont, size: CGFloat) {
        self.font = UIFont.quicksandFont(type, size: size)
    }
}
