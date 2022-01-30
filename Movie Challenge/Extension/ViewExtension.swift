//
//  ViewExtension.swift
//  Movie Challenge
//
//  Created by Moath Yahia on 1/30/22.
//

import UIKit


extension UIView {
    
    func setupBorderView() {
        self.layer.cornerRadius = 12.0
        self.layer.shadowColor = UIColor.green.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1
        self.layer.shadowOffset = CGSize(width: -1, height: 3)
    }
}

