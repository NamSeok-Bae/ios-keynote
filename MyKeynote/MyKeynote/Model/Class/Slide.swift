//
//  Rectangle.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

class Slide: CustomStringConvertible {
    let identifier: String
    private(set) var alpha: Int
    var description: String {
        return "(\(identifier)), Alpha: \(alpha)"
    }
    
    init(identifier: String, alpha: Int) {
        self.identifier = identifier
        self.alpha = alpha
    }
    
    func updateAlpha(alpha: Int) {
        self.alpha = alpha
    }
}
