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

class SlideView: UIView {

    // MARK: - Properties
    
    var isTapped: Bool = false {
        didSet(oldValue) {
	            self.layer.borderWidth = isTapped ? 2 : 0
            self.delegate?.detectTappedSlide(isTapped: isTapped)
        }
    }
    
    private var identifier: SlideIdentifier!
    weak var delegate: SlideDelegate?
    
    // MARK: - LifeCycles
    
    init(identifier: SlideIdentifier, alpha: SlideAlpha) {
        super.init(frame: .zero)
        configureUI()
        setupProperties(identifier: identifier, alpha: alpha)
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
        self.layer.backgroundColor = UIColor.systemGray5.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setBackgroundColorWithAlpha(color: SlideColor, alpha: SlideAlpha) {
        
    }
    
    func setupProperties(identifier: SlideIdentifier, alpha: SlideAlpha) {
        self.identifier = identifier
        self.alpha = CGFloat(alpha.value) / 10
    }
    
    func bindData(data: Slide) {
        setupProperties(identifier: data.identifier,
                        alpha: data.alpha)
    }
}
