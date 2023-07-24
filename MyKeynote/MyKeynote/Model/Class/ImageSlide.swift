//
//  ImageRectangle.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

class ImageSlide: Slide, Equatable {
    static func == (lhs: ImageSlide, rhs: ImageSlide) -> Bool {
        return lhs.description == rhs.description
    }
}
