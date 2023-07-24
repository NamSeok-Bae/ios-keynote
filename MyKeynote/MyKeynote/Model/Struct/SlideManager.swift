//
//  SlideManager.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/20.
//

import Foundation

struct SlideManager {
    private(set) var slideArray: [Slide]
    private let factory: SlideFactory
    var slideCount: Int {
        get {
            slideArray.count
        }
    }
    subscript<T>(index: Int) -> T? {
        return index >= 0 && index < slideCount ? slideArray[index] as? T : nil
    }
    
    init() {
        slideArray = []
        factory = SlideFactory()
    }
    
    mutating func createSquareSlide() {
        slideArray.append(factory.createSlide(creator: SquareSlideFactory()))
    }

    mutating func createImageSlide() {
        slideArray.append(factory.createSlide(creator: ImageSlideFactory()))
    }
    
    mutating func updateSlideAlpha(slideIndex: Int, alpha: Int) {
        slideArray[slideIndex].updateAlpha(alpha: alpha)
    }
    
    mutating func updateSquareSlideBackgroundColor(slideIndex: Int, color: SlideColor) {
        if let slide = slideArray[slideIndex] as? SquareSlide {
            slide.updateBackgroundColor(color: color)
        }
    }
}
