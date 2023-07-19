//
//  Color.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

class Color: CustomStringConvertible {
    var red: Int
    var green: Int
    var blue: Int
    var description: String {
        return "R:\(red), G:\(green), B:\(blue)"
    }
    
    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
}
