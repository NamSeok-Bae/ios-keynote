//
//  SlideIdentifier.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/24.
//

import Foundation

class SlideIdentifier: Equatable {
    static func == (lhs: SlideIdentifier, rhs: SlideIdentifier) -> Bool {
        lhs.value == rhs.value
    }
    
    let value: String
    
    init(identifier: String) {
        self.value = identifier
    }
}
