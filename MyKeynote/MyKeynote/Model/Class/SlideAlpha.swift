//
//  SlideAlpha.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/24.
//

import Foundation

class SlideAlpha {
    private(set) var value: Int
    var cgValue: CGFloat {
        get {
            CGFloat(value) / 10
        }
    }
    
    convenience init() {
        self.init(alpha: 0)
    }
    
    init(alpha: Int) {
        self.value = alpha > 10 ? 10 : alpha < 1 ? 1 : alpha
    }
    
    init(alpha: CGFloat) {
        let alpha = Int(alpha * 10)
        self.value = alpha > 10 ? 10 : alpha < 1 ? 1 : alpha
    }
}
