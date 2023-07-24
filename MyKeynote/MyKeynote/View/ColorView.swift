//
//  ColorView.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/19.
//

import UIKit

class ColorView: UIView {
    
    convenience init(color: UIColor) {
        self.init(frame: CGRect())
        setBackgroundColor(color)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
        setBackgroundColor()
    }
    
    private func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
     func setBackgroundColor(_ color: UIColor = .white) {
        self.backgroundColor = color
    }
}
