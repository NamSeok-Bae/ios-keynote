//
//  MockSlideManager.swift
//  MyKeynoteTests
//
//  Created by 배남석 on 2023/07/24.
//

import Foundation

class MockSlideManager: SlideManager {
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
        factory = DefaultSlideFactory()
    }
    
    func createSquareSlide() {
        let newSlide = factory.createSlide(creator: MockSquareSlideFactory())
        slideArray.append(newSlide)
    }
    
    func createImageSlide() {
        let newSlide = factory.createSlide(creator: MockImageSlideFactory())
        slideArray.append(newSlide)
    }
    
    func updateSlideAlpha(slideIndex: Int, alpha: SlideAlpha) {
        slideArray[0] = factory.createSlide(creator: MockSquareSlideFactory())
        slideArray[0].updateAlpha(alpha: SlideAlpha(alpha: 10))
    }
    
    func updateSquareSlideBackgroundColor(slideIndex: Int, color: SlideColor) {
        slideArray[0] = factory.createSlide(creator: MockSquareSlideFactory())
        if let square = slideArray[0] as? SquareSlide {
            square.updateBackgroundColor(color: SlideColor(red: 255, green: 255, blue: 255))
        }
    }
    
    
}
