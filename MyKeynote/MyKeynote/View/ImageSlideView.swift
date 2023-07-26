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
        button.setImage(UIImage.image?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
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
        self.bindData(data: data)
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
    
    @objc private func touchUpImageButton(sender: UIButton) {
        delegate?.detectTappedSlide(isTapped: isTapped)
        isTapped = !isTapped
    }
    
    @objc private func doubleTappedImageButton(sender: UITapGestureRecognizer) {
        delegate?.presentImagePicker()
    }
    
    func bindData(data: ImageSlide) {
        super.bindData(data: data)
        setupViews()
        configureUI()
        bindImageString(imageString: data.imageString, size: data.size)
    }
    
    func bindImage(image: UIImage) {
        imageButton.setImage(image, for: .normal)
    }
    
    func bindImageString(imageString: String, size: CGSize) {
        if let data = Data(base64Encoded: imageString, options: .ignoreUnknownCharacters),
           let image = UIImage(data: data) {
            let newImage = image.resize(standardSize: size)
            bindImage(image: newImage)
        }
    }
}
