//
//  SlideView.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/20.
//

import UIKit

protocol SlideDelegate: AnyObject {
    func detectSlideTapped(isTapped: Bool)
}

class SlideView<T: Slide>: UIView {
    // MARK: - Properties
    
    var isTapped: Bool = false {
        didSet(oldValue) {
	            self.layer.borderWidth = isTapped ? 2 : 0
            self.delegate?.detectSlideTapped(isTapped: isTapped)
        }
    }
    
    private var identifier: String!
    weak var delegate: SlideDelegate?
    private(set) var data: T? = nil
    
    // MARK: - LifeCycles
    
    init(identifier: String, alpha: Int) {
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
    private func configureUI() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupProperties(identifier: String, alpha: Int) {
        self.identifier = identifier
        self.alpha = CGFloat(alpha) / 10
    }
    
    func bindData(data: T) {
        self.data = data
        setupProperties(identifier: data.identifier,
                        alpha: data.alpha)
    }
}
