//
//  ControlTitleLabel.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/19.
//

import UIKit

class ControlTitleLabel: UILabel {
    convenience init(title: String) {
        self.init(frame: CGRect())
        setTitle(title)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    private func configureUI() {
        self.font = .systemFont(ofSize: 20)
        self.sizeToFit()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setTitle(_ title: String) {
        self.text = title
    }
}
