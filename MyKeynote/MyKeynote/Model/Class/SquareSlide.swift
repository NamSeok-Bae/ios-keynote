//
//  Square.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

class SquareSlide: Slide {
    let sideLength: Int
    private(set) var backgroundColor: SlideColor
    override var description: String {
        return "(\(identifier)), Side: \(sideLength), " + backgroundColor.description + ", Alpah: \(alpha)"
    }
    
    init(identifier: String, alpha: Int, sideLength: Int, backgroundColor: SlideColor) {
        self.sideLength = sideLength
        self.backgroundColor = backgroundColor
        super.init(identifier: identifier, alpha: alpha)
    }
    
    func updateBackgroundColor(color: SlideColor) {
        self.backgroundColor = color
    }
}
