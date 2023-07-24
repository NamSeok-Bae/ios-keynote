//
//  CanvasView.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/19.
//

import UIKit

class SquareView: SlideView<SquareSlide> {
    // MARK: - Properties
    
    // MARK: - LifeCycles
    
    convenience init(data: SquareSlide) {
        self.init(frame: .zero)
        self.bindData(data: data)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Functions
    private func configureUI(color: SlideColor) {
        self.layer.backgroundColor = UIColor(color: color).withAlphaComponent(alpha).cgColor
        self.alpha = 1
    }
    
    override func bindData(data: SquareSlide) {
        super.bindData(data: data)
        configureUI(color: data.backgroundColor)
    }
}
