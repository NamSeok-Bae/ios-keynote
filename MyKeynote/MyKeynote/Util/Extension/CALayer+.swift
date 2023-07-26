//
//  CALayer+.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/20.
//

import UIKit

extension CALayer {
    var backgroundColorAlpha: CGFloat {
        return self.backgroundColor?.alpha ?? 1
    }
    
    func setBackgroundColorWithAlpha(color: SlideColor, alpha: SlideAlpha? = nil) {
        if let alpha {
            backgroundColor = UIColor(color: color).withAlphaComponent(alpha.cgValue).cgColor
        } else {
            backgroundColor = UIColor(color: color).withAlphaComponent(backgroundColorAlpha).cgColor
        }
    }
}
