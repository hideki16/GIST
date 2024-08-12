//
//  DesignSystem.swift
//  Gist
//
//  Created by gabriel hideki on 12/08/24.
//

import Foundation
import UIKit

struct DesignSystem {
    enum Colors {
        static let primaryColor = UIColor(red: 24/255, green: 23/255, blue: 23/255, alpha: 1.00)
        static let secondaryColor = UIColor(red: 40/255, green: 167/255, blue: 69/255, alpha: 1.00)
        static let tertiaryColor = UIColor.white
        static let backgroundColor = UIColor(red: 18/255, green: 16/255, blue: 24/255, alpha: 1)
        static let titleTextColor = UIColor(red: 107/255, green: 164/255, blue: 248/255, alpha: 1.0)
        static let textColor = UIColor(red: 141/255, green: 148/255, blue: 157/255, alpha: 1.0)
    }
    
    enum Fonts {
        static let titleFont = UIFont(name: "Helvetica-Bold", size: 25)
        static let subtitleFont = UIFont(name: "Helvetica-Bold", size: 20)
        static let bodyFont = UIFont(name: "Helvetica", size: 18)
        static let captionFont = UIFont(name: "Helvetica", size: 14)
    }
    
    enum Spacing {
        static let xs: CGFloat = 4
        static let s: CGFloat = 8
        static let m: CGFloat = 16
        static let l: CGFloat = 24
        static let xl: CGFloat = 32
        static let xxl: CGFloat = 40
    }
}
