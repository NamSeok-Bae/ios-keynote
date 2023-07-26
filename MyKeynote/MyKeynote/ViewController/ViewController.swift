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
    private let inspertorView = InspectorView()
    
    private lazy var slideListTableView: UITableView = UITableView(frame: .zero, style: .plain)
    private lazy var slideAddButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.backgroundColor = UIColor.cyan.cgColor
        button.setTitle("( + )", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(touchUpSlideAddButton), for: .touchUpInside)
        
        return button
    }()
    
    // MARK: - Properties
    private var slideManager: DefaultSlideManager!
    private weak var currentView: SlideView<SquareSlide>!
    private var currentBackgroundColor: SlideColor!
    private var currentSelectCellIndex: Int? = nil
    
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
        setupInspectDefault()
        setupNotificationCenter()
    }
    
    // MARK: - Functions
    
    private func setupViews() {
        [
            slideListTableView,
            containerBackgroundView,
            inspertorView,
            slideAddButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func removeAllSubViews(view: UIView) {
        view.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func setupTapGesture() -> UIGestureRecognizer {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapped))
        tapGesture.delegate = self
        
        return tapGesture
    }
    
    private func setupContainerView() {
        containerBackgroundView.addSubview(containerView)
        configureContainerView()
    }
    
    private func setupSlideView(index: Int) {
        if let square = slideManager[index] as? SquareSlide {
            setupInspectOfBackgroundColor(color: square.backgroundColor)
            setupInspectOfAlpha(alpha: square.alpha)
            
            let squareView = SquareView(data: square)
            squareView.isTapped = false
            squareView.delegate = self
            containerView.addSubview(squareView)
            currentView = squareView
            currentSelectCellIndex = index
            
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
    
    private func setupNotificationCenter() {
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
    
    private func setupInspectDefault() {
        currentSelectCellIndex = nil
        currentBackgroundColor = nil
        currentView = nil
        inspertorView.bindDefault()
    }
    
    private func setupInspectOfBackgroundColor(color: SlideColor) {
        currentBackgroundColor = color
        inspertorView.bindBackgroundButton(color: color)
    }
    
    private func setupInspectOfAlpha(alpha: SlideAlpha) {
        inspertorView.bindAlphaStepperAndLabel(alpha: alpha)
    }
    
    // MARK: - Configure Functions
    
    private func configureUI() {
        view.backgroundColor = .systemGray5
        
        configureSlideListTableView()
        configureContainerBackgroundView()
        configureInsperctorView()
        configureSlideAddButton()
    }
    
    private func configureSlideListTableView() {
        slideListTableView.translatesAutoresizingMaskIntoConstraints = false
        slideListTableView.dataSource = self
        slideListTableView.delegate = self
        slideListTableView.dragDelegate = self
        slideListTableView.dropDelegate = self
        slideListTableView.register(SlideListCell.self, forCellReuseIdentifier: SlideListCell.identifier)
        slideListTableView.backgroundColor = .systemGray4
        
        NSLayoutConstraint.activate([
            slideListTableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            slideListTableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            slideListTableView.bottomAnchor.constraint(
                equalTo: slideAddButton.topAnchor
            ),
            slideListTableView.trailingAnchor.constraint(
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
        containerView.addGestureRecognizer(setupTapGesture())
        
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
    
    private func configureInsperctorView() {
        inspertorView.delegate = self
        
        NSLayoutConstraint.activate([
            inspertorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            inspertorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inspertorView.leadingAnchor.constraint(equalTo: containerBackgroundView.trailingAnchor),
            inspertorView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureSlideAddButton() {
        NSLayoutConstraint.activate([
            slideAddButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            slideAddButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            slideAddButton.trailingAnchor.constraint(equalTo: containerBackgroundView.leadingAnchor),
            slideAddButton.heightAnchor.constraint(equalTo: slideAddButton.widthAnchor, multiplier: 0.4)
        ])
    }
    
    // MARK: - Objc Functions
    @objc private func didTapped(sender: UITapGestureRecognizer) {
        currentView.isTapped = currentView.isTapped ? false : true
    }
    
    @objc private func touchUpSlideAddButton(sender: UIButton) {
        slideManager.createSquareSlide()
        slideListTableView.reloadData()
    }
    
    @objc func didUpdateSlideViewAlpha(_ notification: Notification) {
        if let alpha = notification.userInfo?["SlideAlpha"] as? SlideAlpha {
            setupInspectOfAlpha(alpha: alpha)
            currentView.layer.setBackgroundColorWithAlpha(
                color: currentBackgroundColor,
                alpha: alpha
            )
        }
    }
    
    @objc func didUpdateSlideViewBackgroundColor(_ notification: Notification) {
        if let color = notification.userInfo?["SlideColor"] as? SlideColor {
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
}

// MARK: - Slide Delegate
extension ViewController: SlideDelegate {
    func detectTappedSlide(isTapped: Bool) {
        inspertorView.bindTapped(isTapped: isTapped)
    }
}

// MARK: - InspertorView Delegate & UIColorPickVeiw Delegate
extension ViewController: UIColorPickerViewControllerDelegate, InspertorViewDelegate {
    func changeAlphaStepperValue(value: Int) {
        slideManager.updateSlideAlpha(slideIndex: currentSelectCellIndex ?? 0,
                                      alpha: SlideAlpha(alpha: value))
    }
    
    func touchUpBackgroundColorButton(button: UIButton) {
        let backgroundColor = button.layer.backgroundColor ?? UIColor.white.cgColor
        let picker = UIColorPickerViewController()
        picker.selectedColor = UIColor(cgColor: backgroundColor)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let slideColor = uiColorToSlideColor(viewController.selectedColor)
        let alpha = SlideAlpha(alpha: viewController.selectedColor.alpha)
        slideManager.updateSquareSlideBackgroundColor(
            slideIndex: currentSelectCellIndex ?? 0,
            color: slideColor
        )
        slideManager.updateSlideAlpha(
            slideIndex: currentSelectCellIndex ?? 0,
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

// MARK: - TableView Delegate & Datasource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slideManager.slideCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SlideListCell.identifier,
                                                       for: indexPath) as? SlideListCell else {
            return UITableViewCell()
        }
        
        if let slide = slideManager[indexPath.row] {
            cell.bind(slide: slide, index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * (0.5)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        removeAllSubViews(view: containerBackgroundView)
        removeAllSubViews(view: containerView)
        setupInspectDefault()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SlideListCell {
            if cell.isDisplayed && cell.isSelected {
                setupContainerView()
                setupSlideView(index: indexPath.row)
            } else {
                removeAllSubViews(view: containerBackgroundView)
                removeAllSubViews(view: containerView)
                setupInspectDefault()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard let srcCell = tableView.cellForRow(at: sourceIndexPath) as? SlideListCell,
              let destCell = tableView.cellForRow(at: destinationIndexPath) as? SlideListCell else {
            return
        }
        srcCell.bind(index: destinationIndexPath.row)
        destCell.bind(index: sourceIndexPath.row)
        slideManager.moveSlide(sourceIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
}

extension ViewController: UITableViewDragDelegate, UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
}
