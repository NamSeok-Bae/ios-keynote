//
//  Rectangle.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

class Slide: CustomStringConvertible {
    let identifier: SlideIdentifier
    private(set) var alpha: SlideAlpha
    var description: String {
        return "(\(identifier.value)), Alpha: \(alpha.value)"
    }
    
    init(identifier: String) {
        self.identifier = SlideIdentifier(identifier: identifier)
        self.alpha = SlideAlpha(alpha: 10)
    }
    
    init(identifier: String, alpha: Int) {
        self.identifier = SlideIdentifier(identifier: identifier)
        self.alpha = SlideAlpha(alpha: alpha)
    }
    
    func updateAlpha(alpha: SlideAlpha) {
        self.alpha = alpha
    }
}
