//
//  Square.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

class SquareSlide: Slide, Colorable {
    private(set) var color: SlideColor
    
    init(identifier: String, alpha: Int, sideLength: Int, color: SlideColor) {
        self.color = color
        super.init(identifier: identifier, alpha: alpha, size: CGSize(width: sideLength, height: sideLength))
    }
    
    func updateColor(color: SlideColor) {
        self.color = color
    }
}
