//
//  StringDate+Extensions.swift
//  CarlaCaseStudy
//
//  Created by Talha Batuhan Irmalı on 6.06.2024.
//

import Foundation

extension String {
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let dateObject = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            return dateFormatter.string(from: dateObject)
        }
        
        return self
    }
}
