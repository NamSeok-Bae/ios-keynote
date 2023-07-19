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
    
    // MARK: - Properties
    let factory: SlideFactory!
    
    // MARK: - LifeCycles
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        factory = SlideFactory()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        factory = SlideFactory()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 1...4 {
            let temp = factory.createSlide(creator: SquareSlideFactory())
            os_log("Rect%d %s", type: .debug, i, temp.description)
        }
    }
    
    // MARK: - Functions
}

