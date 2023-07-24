//
//  PaddingLabel.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/19.
//

import UIKit

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    convenience init(padding: UIEdgeInsets) {
        self.init(frame: CGRect())
        self.padding = padding
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
}
