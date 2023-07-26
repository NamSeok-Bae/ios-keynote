//
//  SlideListCell.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/24.
//

import UIKit

final class SlideListCell: UITableViewCell {
    // MARK: - UI Properties
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.text = "0"
        label.sizeToFit()
        
        return label
    }()
    
    private let containerView: UIView = ColorView(color: .systemGray5)
    
    private let preview: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray2
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: - Properties
    enum UIImageSystemNameType: String {
        case rectangle = "rectangle.center.inset.filled"
        case image = "photo"
    }
    
    static let identifier = "SlideListCell"
    var isDisplayed: Bool = false {
        didSet {
            self.layer.borderWidth = isDisplayed ? 3 : 0
        }
    }
    
    // MARK: - LifeCycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        configureUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if isDisplayed {
            isDisplayed = false
            super.setSelected(false, animated: animated)
        } else {
            isDisplayed = selected
            super.setSelected(selected, animated: animated)
        }
    }
    
    // MARK: - Functions
    func bind(slide: Slide, index: Int) {
        if slide is SquareSlide {
            preview.image = UIImage(systemName: UIImageSystemNameType.rectangle.rawValue)?.withTintColor(.gray,
                                                                                                renderingMode: .alwaysOriginal)
        } else {
            preview.image = UIImage(systemName: UIImageSystemNameType.image.rawValue)?.withTintColor(.gray,
                                                                        renderingMode: .alwaysOriginal)
        }
        bind(index: index)
    }
    
    func bind(index: Int) {
        numberLabel.text = "\(index + 1)"
    }
    
    private func setupViews() {
        [
            numberLabel,
            containerView
        ].forEach {
            addSubview($0)
        }
        
        containerView.addSubview(preview)
    }
    
    private func configureUI() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.layer.borderColor = UIColor.systemBlue.cgColor
        
        configureContainerView()
        configureSlideListPreview()
        configureNumberLabel()
    }
    
    private func configureContainerView() {
        containerView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func configureSlideListPreview() {
        NSLayoutConstraint.activate([
            preview.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            preview.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            preview.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
            preview.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8)
        ])
    }
    
    private func configureNumberLabel() {
        NSLayoutConstraint.activate([
            numberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: containerView.leadingAnchor),
        ])
    }
}
