//
//  Rectangle.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

protocol Identifierable {
    var identifier: SlideIdentifier { get }
    func updateIdentifier(identifier: SlideIdentifier)
}

protocol Colorable {
    var color: SlideColor { get }
    func updateColor(color: SlideColor)
}

protocol Alphable {
    var alpha: SlideAlpha { get }
    func updateAlpha(alpha: SlideAlpha)
}

protocol Sizeable {
    var size: CGSize { get }
    func updateSize(size: CGSize)
}

protocol ImageURLable {
    var url: URL? { get }
    func updateImageURL(url: URL)
}

class Slide: Identifierable, Alphable, Sizeable {
    private(set) var identifier: SlideIdentifier
    private(set) var alpha: SlideAlpha
    private(set) var size: CGSize
    
    init(identifier: String) {
        self.identifier = SlideIdentifier(identifier: identifier)
        self.alpha = SlideAlpha(alpha: 10)
        self.size = CGSize(width: 100, height: 100)
    }
    
    init(identifier: String, alpha: Int) {
        self.identifier = SlideIdentifier(identifier: identifier)
        self.alpha = SlideAlpha(alpha: alpha)
        self.size = CGSize(width: 100, height: 100)
    }
    
    init(identifier: String, alpha: Int, size: CGSize) {
        self.identifier = SlideIdentifier(identifier: identifier)
        self.alpha = SlideAlpha(alpha: alpha)
        self.size = size
    }
    
    func updateIdentifier(identifier: SlideIdentifier) {
        self.identifier = identifier
    }
    
    func updateAlpha(alpha: SlideAlpha) {
        self.alpha = alpha
    }
    
    func updateSize(size: CGSize) {
        self.size = size
    }
}
