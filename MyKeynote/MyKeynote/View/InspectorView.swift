//
//  InspectorView.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/25.
//

import UIKit

protocol InspertorViewDelegate: AnyObject {
    func touchUpBackgroundColorButton(button: UIButton)
    func changeAlphaStepperValue(value: Int)
}

final class InspectorView: UIView {
    // MARK: - UI Properties
    private let backgroundControlTitleLabel: UILabel = ControlTitleLabel(title: "배경색")
    private let alphaControlTitleLabel: UILabel = ControlTitleLabel(title: "투명도")
    
    private lazy var backgroundControlButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.white.cgColor
        button.setTitleColor(.gray, for: .disabled)
        button.setTitle("비활성화 상태", for: .disabled)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self,
                         action: #selector(touchUpBackgroundColorButton),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var alphaNumberLabel: UILabel = {
        let label = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5))
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 5
        label.layer.backgroundColor = UIColor.white.cgColor
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var alphaStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.layer.cornerRadius = 5
        stepper.maximumValue = 10
        stepper.minimumValue = 1
        stepper.addTarget(self,
                          action: #selector(changeAlphaStepperValue),
                           for: .valueChanged)
        
        return stepper
    }()
    
    // MARK: - Properties
    weak var delegate: InspertorViewDelegate?
    
    // MARK: - LifeCycles
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
        configureUI()
    }
    
    // MARK: - Functions
    private func setupViews() {
        [
            backgroundControlTitleLabel,
            backgroundControlButton,
            alphaControlTitleLabel,
            alphaNumberLabel,
            alphaStepper,
        ].forEach {
            addSubview($0)
        }
    }
    
    private func configureUI() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray4
        
        configureBackgroundControlTitleLabel()
        configureBackgroundControlButton()
        configureAlphaControlTitleLabel()
        configureAlphaNumberLabel()
        configureAlphaStepper()
    }
    
    private func configureBackgroundControlTitleLabel() {
        NSLayoutConstraint.activate([
            backgroundControlTitleLabel.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 10
            ),
            backgroundControlTitleLabel.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 10
            )
        ])
    }
    
    private func configureBackgroundControlButton() {
        NSLayoutConstraint.activate([
            backgroundControlButton.topAnchor.constraint(
                equalTo: backgroundControlTitleLabel.bottomAnchor,
                constant: 10
            ),
            backgroundControlButton.leadingAnchor.constraint(
                equalTo: backgroundControlTitleLabel.leadingAnchor
            ),
            backgroundControlButton.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -10
            ),
            backgroundControlButton.heightAnchor.constraint(
                equalTo: backgroundControlTitleLabel.heightAnchor
            )
        ])
    }
    
    private func configureAlphaControlTitleLabel() {
        NSLayoutConstraint.activate([
            alphaControlTitleLabel.topAnchor.constraint(
                equalTo: backgroundControlButton.bottomAnchor,
                constant: 10
            ),
            alphaControlTitleLabel.leadingAnchor.constraint(
                equalTo: backgroundControlTitleLabel.leadingAnchor
            )
        ])
    }
    
    private func configureAlphaNumberLabel() {
        NSLayoutConstraint.activate([
            alphaNumberLabel.widthAnchor.constraint(
                equalTo: alphaControlTitleLabel.widthAnchor
            ),
            alphaNumberLabel.heightAnchor.constraint(
                equalTo: alphaControlTitleLabel.heightAnchor
            ),
            alphaNumberLabel.topAnchor.constraint(
                equalTo: alphaControlTitleLabel.bottomAnchor,
                constant: 10
            ),
            alphaNumberLabel.leadingAnchor.constraint(
                equalTo: alphaControlTitleLabel.leadingAnchor
            )
        ])
    }
    
    private func configureAlphaStepper() {
        NSLayoutConstraint.activate([
            alphaStepper.leadingAnchor.constraint(
                equalTo: alphaNumberLabel.trailingAnchor,
                constant: 5
            ),
            alphaStepper.heightAnchor.constraint(
                equalTo: alphaNumberLabel.heightAnchor
            ),
            alphaStepper.trailingAnchor.constraint(
                equalTo: backgroundControlButton.trailingAnchor
            ),
            alphaStepper.topAnchor.constraint(
                equalTo: alphaNumberLabel.topAnchor
            )
        ])
    }
    
    func bindDefault() {
        backgroundControlButton.backgroundColor = .white
        backgroundControlButton.isEnabled = false
        alphaNumberLabel.text = ""
        alphaNumberLabel.isEnabled = false
        alphaStepper.isEnabled = false
    }
    
    func bindTapped(isTapped: Bool) {
        alphaNumberLabel.isEnabled = isTapped
        backgroundControlButton.isEnabled = isTapped
        alphaStepper.isEnabled = isTapped
    }
    
    func bindBackgroundButton(color: SlideColor) {
        let uiColor = UIColor(color: color)
        backgroundControlButton.setTitle(
            color.convertHexString(),
            for: .normal
        )
        backgroundControlButton.setTitleColor(
            uiColor.complementaryColor,
            for: .normal
        )
        backgroundControlButton.layer.backgroundColor = uiColor.cgColor
    }
    
    func bindAlphaStepperAndLabel(alpha: SlideAlpha) {
        alphaNumberLabel.text = "\(alpha.value)"
        alphaStepper.value = Double(alpha.value)
    }
    
    @objc private func touchUpBackgroundColorButton(sender: UIButton) {
        delegate?.touchUpBackgroundColorButton(button: sender)
    }
    
    @objc private func changeAlphaStepperValue(sender: UIStepper) {
        delegate?.changeAlphaStepperValue(value: Int(sender.value))
    }
}
