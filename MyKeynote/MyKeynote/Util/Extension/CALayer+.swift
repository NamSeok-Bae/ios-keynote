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
    
    func setBackgroundColorWithAlpha(color: SlideColor, alpha: CGFloat? = nil) {
        backgroundColor = UIColor(color: color).withAlphaComponent(alpha ?? backgroundColorAlpha).cgColor
    }
}
