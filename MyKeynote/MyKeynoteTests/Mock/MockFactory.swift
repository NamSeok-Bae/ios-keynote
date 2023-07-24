//
//  MockFactory.swift
//  MyKeynoteTests
//
//  Created by 배남석 on 2023/07/24.
//

import Foundation

class MockSquareSlideFactory: SlideCreator {
    typealias Value = SquareSlide
    
    func createSlide() -> Value {
        return SquareSlide(identifier: "Sqaure",
                           alpha: 10,
                           sideLength: 100,
                           backgroundColor: SlideColor(red: 10, green: 10, blue: 10))
    }
}

class MockImageSlideFactory: SlideCreator {
    typealias Value = ImageSlide
    
    func createSlide() -> Value {
         return ImageSlide(identifier: "Image",
                           alpha: 10)
    }
}
