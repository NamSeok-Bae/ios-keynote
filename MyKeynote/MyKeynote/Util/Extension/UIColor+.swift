//
//  UIColor+.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/19.
//

import UIKit

extension UIColor {
    var ciColor: CIColor {
        return CIColor(color: self)
    }
    
    var alpha: CGFloat {
        return ciColor.alpha
    }
    
    var complementaryColor: UIColor {
        let red: CGFloat = 1.0 - ciColor.red
        let green: CGFloat = 1.0 - ciColor.green
        let blue: CGFloat = 1.0 - ciColor.blue
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    convenience init(color: SlideColor) {
        self.init(red: CGFloat(color.red) / 255.0,
                  green: CGFloat(color.green) / 255.0,
                  blue: CGFloat(color.blue) / 255.0,
                  alpha: 1)
    }
}
