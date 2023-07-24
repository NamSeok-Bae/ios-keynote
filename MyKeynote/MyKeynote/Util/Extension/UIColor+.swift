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
    
    convenience init(color: SlideColor) {
        self.init(red: CGFloat(color.red) / 255.0,
                  green: CGFloat(color.green) / 255.0,
                  blue: CGFloat(color.blue) / 255.0,
                  alpha: 1)
    }
}
