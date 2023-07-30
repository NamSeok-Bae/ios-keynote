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
    
    var slideColor: SlideColor {
        let ciColor = ciColor
        let red: Int = Int(ciColor.red * 255)
        let green: Int = Int(ciColor.green * 255)
        let blue: Int = Int(ciColor.blue * 255)
        return SlideColor(red: red, green: green, blue: blue)
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
