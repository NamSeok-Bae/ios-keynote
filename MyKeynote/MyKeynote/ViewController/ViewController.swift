//
//  ViewController.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    // MARK: - UI Properties
    
    private let containerBackgroundView: UIView = ColorView(color: .systemGray2)
    private let containerView: UIView = ColorView()
    private let leftView: UIView = ColorView(color: .red)
    private let backgroundControlTitleLabel: UILabel = ControlTitleLabel(title: "배경색")
    private let alphaControlTitleLabel: UILabel = ControlTitleLabel(title: "투명도")
    
    private lazy var backgroundControlButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false
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
        label.isEnabled = false
        label.layer.cornerRadius = 5
        label.layer.backgroundColor = UIColor.white.cgColor
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    private lazy var alphaStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.isEnabled = false
        stepper.layer.cornerRadius = 5
        stepper.maximumValue = 10
        stepper.minimumValue = 0
        stepper.addTarget(self,
                          action: #selector(changeAlphaStepperValue),
                           for: .valueChanged)
        
        return stepper
    }()
    
    // MARK: - Properties
    private var slideManager: DefaultSlideManager!
    private weak var currentView: SlideView<SquareSlide>!
    private var currentBackgroundColor: SlideColor!
    private let tempSlideIndex = 0
    
    // MARK: - LifeCycles
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        slideManager = DefaultSlideManager()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        slideManager = DefaultSlideManager()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureUI()
        
        setupNotificationCenter()
        setupContainerView()
        setupTapGesture()
        
        slideManager.createSquareSlide()
    }
    
    // MARK: - Functions
    
    private func setupViews() {
        [
            leftView,
            containerBackgroundView,
            backgroundControlTitleLabel,
            backgroundControlButton,
            alphaControlTitleLabel,
            alphaNumberLabel,
            alphaStepper
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupContainerView() {
        view.addSubview(containerView)
        configureContainerView()
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewDidTapped))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didCreateSlideView(_:)),
            name: NSNotification.Name.slideViewCreate,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didUpdateSlideViewAlpha(_:)),
            name: NSNotification.Name.slideViewAlphaUpdate,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didUpdateSlideViewBackgroundColor(_:)),
            name: NSNotification.Name.slideViewBackgroundColorUpdate,
            object: nil
        )
    }
    
    private func configureUI() {
        view.backgroundColor = .systemGray5
        
        configureLeftView()
        configureContainerBackgroundView()
        configureBackgroundControlTitleLabel()
        configureBackgroundControlButton()
        configureAlphaControlTitleLabel()
        configureAlphaNumberLabel()
        configureAlphaStepper()
    }
    
    private func configureLeftView() {
        NSLayoutConstraint.activate([
            leftView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            leftView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            leftView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            leftView.trailingAnchor.constraint(
                equalTo: containerBackgroundView.leadingAnchor
            )
        ])
    }
    
    private func configureContainerBackgroundView() {
        NSLayoutConstraint.activate([
            containerBackgroundView.widthAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.widthAnchor,
                multiplier: 0.7
            ),
            containerBackgroundView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            containerBackgroundView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            ),
            containerBackgroundView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                constant: -view.frame.width * 0.15
            )
        ])
    }
    
    private func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(
                equalTo: containerBackgroundView.widthAnchor
            ),
            containerView.heightAnchor.constraint(
                equalTo: containerBackgroundView.widthAnchor,
                multiplier: 3/4
            ),
            containerView.centerXAnchor.constraint(
                equalTo: containerBackgroundView.centerXAnchor
            ),
            containerView.centerYAnchor.constraint(
                equalTo: containerBackgroundView.centerYAnchor
            )
        ])
    }
    
    private func configureBackgroundControlTitleLabel() {
        NSLayoutConstraint.activate([
            backgroundControlTitleLabel.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            backgroundControlTitleLabel.leadingAnchor.constraint(
                equalTo: containerBackgroundView.trailingAnchor,
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
                equalTo: view.safeAreaLayoutGuide.trailingAnchor,
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
    
    private func setupInspectOfBackgroundColor(color: SlideColor) {
        let uiColor = UIColor(color: color)
        currentBackgroundColor = color
        backgroundControlButton.setTitle(
            color.convertHexString(),
            for: .normal
        )
        backgroundControlButton.setTitleColor(
            uiColorToComplementaryColor(uiColor),
            for: .normal
        )
        backgroundControlButton.layer.backgroundColor = uiColor.cgColor
    }
    
    private func setupInspectOfAlpha(alpha: Int) {
        alphaNumberLabel.text = "\(alpha)"
        alphaStepper.value = Double(alpha)
    }
    
    // MARK: - Objc Functions
    @objc private func viewDidTapped(sender: UITapGestureRecognizer) {
        currentView.isTapped = currentView.isTapped ? false : true
    }
    
    @objc private func changeAlphaStepperValue(sender: UIStepper) {
        let alpha = Int(alphaStepper.value)
        slideManager.updateSlideAlpha(slideIndex: tempSlideIndex,
                                      alpha: alpha)
    }
    
    @objc func didCreateSlideView(_ notification: Notification) {
        if let square = notification.object as? SquareSlide {
            setupInspectOfBackgroundColor(color: square.backgroundColor)
            setupInspectOfAlpha(alpha: square.alpha.value)
            
            let squareView = SquareView(data: square)
            squareView.delegate = self
            containerView.addSubview(squareView)
            currentView = squareView
            
            NSLayoutConstraint.activate([
                squareView.widthAnchor.constraint(
                    equalToConstant: CGFloat(square.sideLength)
                ),
                squareView.heightAnchor.constraint(
                    equalToConstant: CGFloat(square.sideLength)
                ),
                squareView.centerXAnchor.constraint(
                    equalTo: containerView.centerXAnchor
                ),
                squareView.centerYAnchor.constraint(
                    equalTo: containerView.centerYAnchor
                )
            ])
        } else {
            // ImageSlide
        }
    }
    
    @objc func didUpdateSlideViewAlpha(_ notification: Notification) {
        if let alpha = notification.object as? Int {
            setupInspectOfAlpha(alpha: alpha)
            currentView.layer.setBackgroundColorWithAlpha(
                color: currentBackgroundColor,
                alpha: CGFloat(alpha) / 10
            )
        }
    }
    
    @objc func didUpdateSlideViewBackgroundColor(_ notification: Notification) {
        if let color = notification.object as? SlideColor {
            setupInspectOfBackgroundColor(color: color)
            currentView.layer.setBackgroundColorWithAlpha(color: color)
        }
    }
    
    // MARK: - UIColor Functions
    private func uiColorToSlideColor(_ uiColor: UIColor) -> SlideColor {
        let ciColor = uiColor.ciColor
        let red: Int = Int(ciColor.red * 255)
        let green: Int = Int(ciColor.green * 255)
        let blue: Int = Int(ciColor.blue * 255)
        
        return SlideColor(red: red, green: green, blue: blue)
    }
    
    private func uiColorToComplementaryColor(_ uiColor: UIColor) -> UIColor {
        let ciColor = uiColor.ciColor
        let red: CGFloat = 1.0 - ciColor.red
        let green: CGFloat = 1.0 - ciColor.green
        let blue: CGFloat = 1.0 - ciColor.blue
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// MARK: - RandomValueCreator Protocol
extension ViewController: UIColorPickerViewControllerDelegate {
    @objc private func touchUpBackgroundColorButton(sender: UIButton) {
        let backgroundColor = backgroundControlButton.layer.backgroundColor ?? UIColor.white.cgColor
        let picker = UIColorPickerViewController()
        picker.selectedColor = UIColor(cgColor: backgroundColor)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    // colorPickerViewController 선택 종료시 호출
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let slideColor = uiColorToSlideColor(viewController.selectedColor)
        let alpha = Int(viewController.selectedColor.alpha * 10)
        slideManager.updateSquareSlideBackgroundColor(
            slideIndex: tempSlideIndex,
            color: slideColor
        )
        slideManager.updateSlideAlpha(
            slideIndex: tempSlideIndex,
            alpha: alpha
        )
    }
}

// MARK: - UIGestureRecognizerDelegate Delegate
extension ViewController: UIGestureRecognizerDelegate {
    // SuperView Touch를 허용할지 안할지 판단
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        return touch.view as? ColorView != nil && currentView.isTapped ? true : false
    }
}

// MARK: - Slide Delegate
extension ViewController: SlideDelegate {
    func detectSlideTapped(isTapped: Bool) {
        alphaNumberLabel.isEnabled = isTapped
        backgroundControlButton.isEnabled = isTapped
        alphaStepper.isEnabled = isTapped
    }
}
