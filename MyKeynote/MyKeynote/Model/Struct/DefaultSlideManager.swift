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
    func createRamdomSlide()
    func updateCurrentUseIndex(index: Int)
    func updateSlideAlpha(alpha: SlideAlpha)
    func updateImageSlideImageURL(url: URL)
    func updateImageSlideSize(size: CGSize)
    func moveSlide(sourceIndex: Int, destinationIndex: Int)
    func searchSlideByIdentifier(identifier: String)
}

class DefaultSlideManager: SlideManager {
    enum MoveType {
        case front
        case back
        case forward
        case backward
    }
    
    private(set) var slideArray: [Slide]
    private let factory: SlideFactory
    private(set) var currentUseIndex: Int?
    var slideCount: Int {
        get {
            slideArray.count
        }
    }
    subscript(index: Int) -> Slide? {
        return index >= 0 && index < slideArray.count ? slideArray[index] : nil
    }
    
    init(factory: SlideFactory) {
        self.factory = factory
        slideArray = []
        currentUseIndex = nil
    }
    
    func createSquareSlide() {
        let newSlide = factory.createSlide(creator: SquareSlideFactory())
        slideArray.append(newSlide)
    }

    func createImageSlide() {
        let newSlide = factory.createSlide(creator: ImageSlideFactory())
        slideArray.append(newSlide)
    }
    
    func createRamdomSlide() {
        if Int.random(in: 1...10) % 2 == 1 {
            createSquareSlide()
        } else {
            createImageSlide()
        }
    }
    
    func updateCurrentUseIndex(index: Int) {
        self.currentUseIndex = index
    }
    
    func updateSlideAlpha(alpha: SlideAlpha) {
        if let index = currentUseIndex {
            slideArray[index].updateAlpha(alpha: alpha)
            NotificationCenter.default.post(
                name: NSNotification.Name.slideViewAlphaUpdate,
                object: nil,
                userInfo: ["SlideAlpha": alpha]
            )
        }
    }
    
    func updateSquareSlideBackgroundColor(color: SlideColor) {
        if let index = currentUseIndex,
           let slide = slideArray[index] as? SquareSlide {
            slide.updateBackgroundColor(color: color)
            NotificationCenter.default.post(
                name: NSNotification.Name.slideViewBackgroundColorUpdate,
                object: nil,
                userInfo: ["SlideColor": color]
            )
        }
    }
    
    func updateImageSlideImageURL(url: URL) {
        if let index = currentUseIndex,
           let slide = slideArray[index] as? ImageSlide {
            slide.updateImageURL(url: url)
            NotificationCenter.default.post(
                name: NSNotification.Name.slideViewImageURLUpdate,
                object: nil,
                userInfo: ["SlideImageURL": url]
            )
        }
    }
    
    func updateImageSlideSize(size: CGSize) {
        if let index = currentUseIndex,
           let slide = slideArray[index] as? ImageSlide {
            slide.updateSize(size: size)
            NotificationCenter.default.post(
                name: NSNotification.Name.slideViewSizeUpdate,
                object: nil,
                userInfo: ["SlideSize": slide.size]
            )
        }
    }
    
    func moveSlide(sourceIndex: Int, destinationIndex: Int) {
        if sourceIndex == destinationIndex { return }
        
        let slide = slideArray.remove(at: sourceIndex)
        slideArray.insert(slide, at: destinationIndex)
        NotificationCenter.default.post(
            name: Notification.Name.slideViewMove,
            object: nil,
            userInfo: ["isSlideMoved": true]
        )
    }
    
    func moveSlide(moveType: MoveType) {
        guard let currentUseIndex else { return }
        let forwardIndex = currentUseIndex == 0 ? 0 : currentUseIndex - 1
        let backwardIndex = currentUseIndex == slideCount - 1 ? slideCount - 1 : currentUseIndex + 1
        
        switch moveType {
        case .front:
            moveSlide(sourceIndex: currentUseIndex, destinationIndex: 0)
        case .back:
            moveSlide(sourceIndex: currentUseIndex, destinationIndex: slideCount - 1)
        case .forward:
            moveSlide(sourceIndex: currentUseIndex, destinationIndex: forwardIndex)
        case .backward:
            moveSlide(sourceIndex: currentUseIndex, destinationIndex: backwardIndex)
        }
    }
    
    func searchSlideByIdentifier(identifier: String) {
        for (idx, slide) in slideArray.enumerated() {
            if slide.identifier.value == identifier {
                currentUseIndex = idx
                break
            }
        }
    }
}
