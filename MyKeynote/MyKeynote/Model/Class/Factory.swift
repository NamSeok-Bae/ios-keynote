//
//  Factory.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

protocol SlideCreator: RandomValueCreator {
    associatedtype Value
    func createSlide() -> Value
}

class SquareSlideFactory: SlideCreator {
    typealias Value = SquareSlide
    
    func createSlide() -> Value {
        return SquareSlide(identifier: createRandomIdentifier(),
                           alpha: createRandomInt(range: 0...10),
                           sideLength: createRandomInt(range: 100...500),
                           backgroundColor: createRandomColor())
    }
}

class ImageSlideFactory: SlideCreator {
    typealias Value = ImageSlide
    
    func createSlide() -> Value {
         return ImageSlide(identifier: createRandomIdentifier(),
                           alpha: createRandomInt(range: 0...10))
    }
}

protocol SlideFactory {
    func createSlide<T: SlideCreator>(creator: T) -> T.Value
}

class DefaultSlideFactory: SlideFactory {
    func createSlide<T: SlideCreator>(creator: T) -> T.Value {
        return creator.createSlide()
    }
}
