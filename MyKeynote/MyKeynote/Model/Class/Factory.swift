//
//  Factory.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

protocol SlideCreator: RandomValueCreator {
    func createSlide() -> Slide
}

class SquareSlideFactory: SlideCreator {
    func createSlide() -> Slide {
        return SquareSlide(identifier: createRandomIdentifier(),
                      alpha: createRandomInt(range: 0...10),
                      sideLength: createRandomInt(range: 100...500),
                      backgroundColor: createRandomColor())
    }
}

class ImageSlideFactory: SlideCreator {
    func createSlide() -> Slide {
         return ImageSlide(identifier: createRandomIdentifier(),
                               alpha: createRandomInt(range: 0...10))
    }
}

class SlideFactory {
    func createSlide(creator: SlideCreator) -> Slide {
        return creator.createSlide()
    }
}
