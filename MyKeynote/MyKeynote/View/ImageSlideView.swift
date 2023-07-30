//
//  ImageView.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/26.
//

import UIKit

class ImageSlideView: SlideView, SlideViewAlphable, SlideViewImageable {
    // MARK: - Properties
    lazy var imageButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage.photo?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 5
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(doubleTappedImageButton))
        gesture.numberOfTapsRequired = 2
        button.addGestureRecognizer(gesture)
        button.addTarget(self, action: #selector(touchUpImageButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - LifeCycles
    
    override init(identifier: SlideIdentifier) {
        super.init(identifier: identifier)
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Functions
    
    private func setupViews() {
        addSubview(imageButton)
        
        configureImageButton()
    }
    
    func configureImageButton() {
        NSLayoutConstraint.activate([
            imageButton.topAnchor.constraint(equalTo: self.topAnchor),
            imageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func updateAlpha(alpha: SlideAlpha) {
        self.imageButton.imageView?.alpha = alpha.cgValue
    }
    
    func updateImage(imageURL: URL?) {
        if let url = imageURL {
            self.imageButton.setImage(UIImage(url: url), for: .normal)
        }
    }
    
    @objc private func touchUpImageButton(sender: UIButton) {
        delegate?.detectTappedSlide(isTapped: isTapped)
        isTapped = !isTapped
    }
    
    @objc private func doubleTappedImageButton(sender: UITapGestureRecognizer) {
        delegate?.presentImagePicker()
    }
    
    func setImage(image: UIImage) {
        imageButton.setImage(image, for: .normal)
    }
}
