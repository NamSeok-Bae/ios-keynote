//
//  ImageRectangle.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

class ImageSlide: Slide, ImageURLable {
    private(set) var url: URL? = nil
    
    override init(identifier: String) {
        super.init(identifier: identifier)
    }
    
    func updateImageURL(url: URL) {
        self.url = url
    }
}
