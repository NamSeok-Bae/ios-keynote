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
    private weak var currentView: SlideView!
    private var currentBackgroundColor: SlideColor!
    
    // MARK: - LifeCycles
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        slideManager = DefaultSlideManager(factory: DefaultSlideFactory())
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        slideManager = DefaultSlideManager(factory: DefaultSlideFactory())
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
        slideManager.updateCurrentUseIndex(index: index)
        
        if let square = slideManager[index] as? SquareSlide {
            setupInspectOfBackgroundColor(color: square.color)
            setupInspectOfAlpha(alpha: square.alpha)
            
            let squareView = SquareSlideView(data: square)
            squareView.isTapped = false
            squareView.delegate = self
            containerView.addSubview(squareView)
            configureSlideView(size: square.size, view: squareView)
            currentView = squareView
        } else if let image = slideManager[index] as? ImageSlide {
            setupInspectOfBackgroundColor(color: uiColorToSlideColor(.systemGray5))
            setupInspectOfAlpha(alpha: image.alpha)
            
            let imageView = ImageSlideView(data: image)
            imageView.isTapped = false
            imageView.delegate = self
            containerView.addSubview(imageView)
            configureSlideView(size: image.size, view: imageView)
            currentView = imageView
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didMovedSlide(_:)),
            name: NSNotification.Name.slideViewMove,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didUpdateSlideImageURL(_:)),
            name: NSNotification.Name.slideViewImageURLUpdate,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didUpdateSlideSize(_:)),
            name: NSNotification.Name.slideViewSizeUpdate,
            object: nil
        )
    }
    
    private func setupInspectDefault() {
        currentBackgroundColor = nil
        currentView = nil
        inspertorView.bindDefault()
    }
    
    private func setupInspectOfBackgroundColor(color: SlideColor) {
        currentBackgroundColor = color
        inspertorView.updateBackgroundButton(color: color)
    }
    
    private func setupInspectOfAlpha(alpha: SlideAlpha) {
        inspertorView.updateAlphaStepperAndLabel(alpha: alpha)
    }
    
    private func removeAllConstraint(view: UIView) {
        view.constraints.forEach {
            $0.isActive = false
        }
    }
    
    private func removeAllSubViews(view: UIView) {
        view.subviews.forEach {
            $0.removeFromSuperview()
        }
    }
    
    private func initailizeViews() {
        removeAllSubViews(view: containerBackgroundView)
        removeAllSubViews(view: containerView)
        setupInspectDefault()
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
        slideListTableView.register(SlideListCell.self, forCellReuseIdentifier: SlideListCell.reuseIdentifier)
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
    
    private func configureSlideView(size: CGSize, view: SlideView) {
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(
                equalToConstant: size.width
            ),
            view.heightAnchor.constraint(
                equalToConstant: size.height
            ),
            view.centerXAnchor.constraint(
                equalTo: containerView.centerXAnchor
            ),
            view.centerYAnchor.constraint(
                equalTo: containerView.centerYAnchor
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
    
    // MARK: - Objc Action Functions
    @objc private func didTapped(sender: UITapGestureRecognizer) {
        currentView.isTapped = currentView.isTapped ? false : true
    }
    
    @objc private func touchUpSlideAddButton(sender: UIButton) {
        slideManager.createRamdomSlide()
        initailizeViews()
        slideListTableView.reloadData()
    }
    
    @objc func didUpdateSlideViewAlpha(_ notification: Notification) {
        if let alpha = notification.userInfo?["SlideAlpha"] as? SlideAlpha {
            setupInspectOfAlpha(alpha: alpha)
            currentView.setBackgroundColorWithAlpha(color: currentBackgroundColor, alpha: alpha)
        }
    }
    
    @objc func didUpdateSlideViewBackgroundColor(_ notification: Notification) {
        if let color = notification.userInfo?["SlideColor"] as? SlideColor {
            setupInspectOfBackgroundColor(color: color)
            currentView.layer.setBackgroundColor(color: color)
        }
    }
    
    @objc func didMovedSlide(_ notification: Notification) {
        if let isMoved = notification.userInfo?["isSlideMoved"] as? Bool, isMoved {
            removeAllSubViews(view: containerBackgroundView)
            removeAllSubViews(view: containerView)
            setupInspectDefault()
            slideListTableView.reloadData()
        }
    }
    
    @objc func didUpdateSlideImageURL(_ notification: Notification) {
        if let imageURL = notification.userInfo?["SlideImageURL"] as? URL,
           let imageView = currentView as? ImageSlideView,
           let image = UIImage(url: imageURL) {
            let newImage = image.resize(standardSize: containerView.frame.size)
            slideManager.updateImageSlideSize(size: newImage.size)
            imageView.setImage(image: newImage)
        }
    }
    
    @objc func didUpdateSlideSize(_ notification: Notification) {
        if let size = notification.userInfo?["SlideSize"] as? CGSize,
           let imageView = currentView as? ImageSlideView {
            removeAllConstraint(view: imageView)
            configureSlideView(size: size, view: imageView)
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
        inspertorView.updateTapped(isTapped: isTapped, curretViewType: type(of: currentView))
    }
    
    func presentImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
}

// MARK: - UIImagePickerController Delegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false) { () in
            let alert = UIAlertController(title: "", message: "이미지 선택이 취소되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false) { [weak self] () in
            guard let self,
                  let url = info[UIImagePickerController.InfoKey.imageURL] as? URL else { return }
            self.slideManager.updateImageSlideImageURL(url: url)
            
        }
    }
}

// MARK: - InspertorView Delegate
extension ViewController: InspertorViewDelegate {
    func changeAlphaStepperValue(value: Int) {
        slideManager.updateSlideAlpha(alpha: SlideAlpha(alpha: value))
    }
    
    func touchUpBackgroundColorButton(button: UIButton) {
        let backgroundColor = button.layer.backgroundColor ?? UIColor.white.cgColor
        let picker = UIColorPickerViewController()
        picker.selectedColor = UIColor(cgColor: backgroundColor)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}

// MARK: - UIColorPickerViewControllerDelegate
extension ViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let slideColor = uiColorToSlideColor(viewController.selectedColor)
        let alpha = SlideAlpha(alpha: viewController.selectedColor.alpha)
        slideManager.updateSquareSlideBackgroundColor(color: slideColor)
        slideManager.updateSlideAlpha(alpha: alpha)
    }
}

// MARK: - UIGestureRecognizerDelegate
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SlideListCell.reuseIdentifier,
                                                       for: indexPath) as? SlideListCell else {
            return UITableViewCell()
        }
        cell.addInteraction(UIContextMenuInteraction(delegate: self))
        
        if let slide = slideManager[indexPath.row] {
            cell.bind(slide: slide, index: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * (0.5)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        initailizeViews()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SlideListCell {
            if cell.isDisplayed && cell.isSelected {
                setupContainerView()
                setupSlideView(index: indexPath.row)
            } else {
                initailizeViews()
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

// MARK: - UIContextMenuInteraction Delegate
extension ViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard let cell = interaction.view as? SlideListCell else { return nil }
        slideManager.searchSlideByIdentifier(identifier: cell.identifier)
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self] (_: [UIMenuElement]) -> UIMenu? in
            guard let self else { return UIMenu() }
            let btn1 = UIAction(title: "맨 앞으로 보내기") { (UIAction) in
                self.slideManager.moveSlide(moveType: .front)
            }
            let btn2 = UIAction(title: "앞으로 보내기") { (UIAction) in
                self.slideManager.moveSlide(moveType: .forward)
            }
            let btn3 = UIAction(title: "뒤로 보내기") { (UIAction) in
                self.slideManager.moveSlide(moveType: .backward)
            }
            let btn4 = UIAction(title: "맨 뒤로 보내기") { (UIAction) in
                self.slideManager.moveSlide(moveType: .back)
            }
            
            return UIMenu(children: [btn1, btn2, btn3, btn4])
        }
    }
}
