//
//  Color.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

class SlideColor: CustomStringConvertible {
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
    
    func convertHexString() -> String {
        let redHex = String(format: "%02X", red)
        let greenHex = String(format: "%02X", green)
        let blueHex = String(format: "%02X", blue)
        
        return "0x\(redHex)\(greenHex)\(blueHex)"
    }
}
