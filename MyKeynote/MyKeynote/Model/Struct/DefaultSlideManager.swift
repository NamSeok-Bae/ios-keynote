//
//  SlideManager.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/20.
//

import Foundation

protocol SlideManager {
    func createSquareSlide()
    func createImageSlide()
    func updateSlideAlpha(slideIndex: Int, alpha: SlideAlpha)
    func updateSquareSlideBackgroundColor(slideIndex: Int, color: SlideColor)
}

class DefaultSlideManager: SlideManager {
    private(set) var slideArray: [Slide]
    private let factory: SlideFactory
    var slideCount: Int {
        get {
            slideArray.count
        }
    }
    subscript(index: Int) -> Slide? {
        return index >= 0 && index < slideArray.count ? slideArray[index] : nil
    }
    
    init() {
        slideArray = []
        factory = DefaultSlideFactory()
    }
    
    func createSquareSlide() {
        let newSlide = factory.createSlide(creator: SquareSlideFactory())
        slideArray.append(newSlide)
    }

    func createImageSlide() {
        let newSlide = factory.createSlide(creator: ImageSlideFactory())
        slideArray.append(newSlide)
    }
    
    func updateSlideAlpha(slideIndex: Int, alpha: SlideAlpha) {
        slideArray[slideIndex].updateAlpha(alpha: alpha)
        NotificationCenter.default.post(
            name: NSNotification.Name.slideViewAlphaUpdate,
            object: alpha
        )
    }
    
    func updateSquareSlideBackgroundColor(slideIndex: Int, color: SlideColor) {
        if let slide = slideArray[slideIndex] as? SquareSlide {
            slide.updateBackgroundColor(color: color)
            NotificationCenter.default.post(
                name: NSNotification.Name.slideViewBackgroundColorUpdate,
                object: color
            )
        }
    }
    
    func moveSlide(sourceIndex: Int, destinationIndex: Int) {
        if sourceIndex == destinationIndex { return }
        
        let slide = slideArray[sourceIndex]
        slideArray.remove(at: sourceIndex)
        slideArray.insert(slide, at: destinationIndex)
    }
}
