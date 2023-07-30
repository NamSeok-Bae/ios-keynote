//
//  SlideView.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/20.
//

import UIKit

protocol SlideDelegate: AnyObject {
    func detectTappedSlide(isTapped: Bool)
    func presentImagePicker()
}

protocol SlideViewColorable {
    func setBackgroundColorWithAlpha(color: SlideColor, alpha: SlideAlpha)
}

protocol SlideViewBackgroundColorable {
    func updateBackgroundColor(color: SlideColor)
}

protocol SlideViewAlphable {
    func updateAlpha(alpha: SlideAlpha)
}

protocol SlideViewImageable {
    func updateImage(imageURL: URL?)
}

class SlideView: UIView {
    
    // MARK: - Properties
    
    var isTapped: Bool = false {
        didSet(oldValue) {
	            self.layer.borderWidth = isTapped ? 2 : 0
            self.delegate?.detectTappedSlide(isTapped: isTapped)
        }
    }
    
    private(set)var identifier: SlideIdentifier!
    weak var delegate: SlideDelegate?
    
    // MARK: - LifeCycles
    init(identifier: SlideIdentifier) {
        super.init(frame: .zero)
        configureUI()
        updateIdentifier(identifier: identifier)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTapped = !isTapped
    }
    
    // MARK: - Functions
    func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.backgroundColor = UIColor.systemGray5.cgColor
    }
    
    func updateIdentifier(identifier: SlideIdentifier) {
        self.identifier = identifier
    }
}
