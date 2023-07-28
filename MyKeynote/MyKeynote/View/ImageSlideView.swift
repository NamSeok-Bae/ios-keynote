//
//  ImageView.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/26.
//

import UIKit

class ImageSlideView: SlideView {
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
    
    convenience init(data: ImageSlide) {
        self.init(frame: .zero)
        self.setupProperties(data: data)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    
    override func setBackgroundColorWithAlpha(color: SlideColor, alpha: SlideAlpha) {
        self.imageButton.imageView?.alpha = alpha.cgValue
    }
    
    @objc private func touchUpImageButton(sender: UIButton) {
        delegate?.detectTappedSlide(isTapped: isTapped)
        isTapped = !isTapped
    }
    
    @objc private func doubleTappedImageButton(sender: UITapGestureRecognizer) {
        delegate?.presentImagePicker()
    }
    
    func setupProperties(data: ImageSlide) {
        super.setupProperties(data: data)
        setupViews()
        configureUI()
        
        if let url = data.url {
            setImage(imageURL: url, size: data.size)
        }
    }
    
    func setImage(image: UIImage) {
        imageButton.setImage(image, for: .normal)
    }
    
    func setImage(imageURL: URL, size: CGSize) {
        if let image = UIImage(url: imageURL) {
            let newImage = image.resize(standardSize: size)
            setImage(image: newImage)
        }
    }
}
