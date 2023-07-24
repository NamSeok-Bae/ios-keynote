//
//  SlideAlpha.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/24.
//

import Foundation

class SlideAlpha {
    private(set) var value: Int
    
    convenience init() {
        self.init(alpha: 0)
    }
    
    init(alpha: Int) {
        self.value = alpha > 10 ? 10 : alpha < 0 ? 0 : alpha
    }
    
    func updateAlpha(_ alpha: Int) {
        self.value = alpha > 10 ? 10 : alpha < 0 ? 0 : alpha
    }
}
