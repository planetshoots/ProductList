//
//  UIViewExtension.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 10/04/24.
//

import Foundation
import UIKit

extension UIView {
    func round(_ radious: CGFloat = 5) {
        self.layer.cornerRadius = radious
        self.clipsToBounds = true
    }
    
    func addBorder(color: UIColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
