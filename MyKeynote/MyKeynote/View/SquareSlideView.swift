//
//  CanvasView.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/19.
//

import UIKit

class SquareSlideView: SlideView, SlideViewBackgroundColorable, SlideViewAlphable {
    // MARK: - Properties
    
    // MARK: - LifeCycles
    
    override init(identifier: SlideIdentifier) {
        super.init(identifier: identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    func updateBackgroundColor(color: SlideColor) {
        self.layer.setBackgroundColor(color: color)
    }
    
    func updateAlpha(alpha: SlideAlpha) {
        self.layer.setAlpha(alpha: alpha)
    }
}
