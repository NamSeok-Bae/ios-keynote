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
    
    private(set) var size: CGSize = CGSize(width: 100, height: 100)
    private(set) var imageURL: URL!
    
    func updateImageURL(url: URL) {
        imageURL = url
    }
    
    func updateSize(size: CGSize) {
        self.size = size
    }
}
