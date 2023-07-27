//
//  UIImage+.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/26.
//

import UIKit

extension UIImage {
    static let rectangle = UIImage(systemName: "rectangle.center.inset.filled")
    static let image = UIImage(systemName: "photo")
    
    convenience init(slide: Slide) {
        self.init(systemName: slide is SquareSlide ? "rectangle.center.inset.filled" : "photo")!
    }
    
    convenience init?(url: URL) {
        if let data = try? Data(contentsOf: url) {
            self.init(data: data)
            return
        }
        return nil
    }
    
    func resize(standardSize: CGSize) -> UIImage {
        let scaleByWidth = standardSize.width / self.size.width
        let scaleByHeight = standardSize.height / self.size.height
        
        let scale = scaleByWidth > scaleByHeight ? scaleByHeight : scaleByWidth
        let newWidth = self.size.width * scale
        let newHeight = self.size.height * scale

        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
        
        return renderImage
    }
}
