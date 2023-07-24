//
//  SlideManager.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/20.
//

import Foundation

protocol SlideManager {
    mutating func createSquareSlide()
    mutating func createImageSlide()
    mutating func updateSlideAlpha(slideIndex: Int, alpha: Int)
    mutating func updateSquareSlideBackgroundColor(slideIndex: Int, color: SlideColor)
}

struct DefaultSlideManager: SlideManager {
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
    
    mutating func createSquareSlide() {
        let newSlide = factory.createSlide(creator: SquareSlideFactory())
        slideArray.append(newSlide)
        NotificationCenter.default.post(
            name: Notification.Name.slideViewCreate,
            object: newSlide
        )
    }

    mutating func createImageSlide() {
        let newSlide = factory.createSlide(creator: ImageSlideFactory())
        slideArray.append(newSlide)
        NotificationCenter.default.post(
            name: Notification.Name.slideViewCreate,
            object: newSlide
        )
    }
    
    mutating func updateSlideAlpha(slideIndex: Int, alpha: Int) {
        slideArray[slideIndex].updateAlpha(alpha: alpha)
        NotificationCenter.default.post(
            name: NSNotification.Name.slideViewAlphaUpdate,
            object: alpha
        )
    }
    
    mutating func updateSquareSlideBackgroundColor(slideIndex: Int, color: SlideColor) {
        if let slide = slideArray[slideIndex] as? SquareSlide {
            slide.updateBackgroundColor(color: color)
            NotificationCenter.default.post(
                name: NSNotification.Name.slideViewBackgroundColorUpdate,
                object: color
            )
        }
    }
}
