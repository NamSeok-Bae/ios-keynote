//
//  Color.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

class SlideColor: CustomStringConvertible, Equatable {
    static func == (lhs: SlideColor, rhs: SlideColor) -> Bool {
        return lhs.description == rhs.description
    }
    
    var red: Int
    var green: Int
    var blue: Int
    var description: String {
        return "R:\(red), G:\(green), B:\(blue)"
    }
    
    init(red: Int, green: Int, blue: Int) {
        self.red = red > 255 ? 255 : red < 0 ? 0 : red
        self.green = green > 255 ? 255 : green < 0 ? 0 : green
        self.blue = blue > 255 ? 255 : blue < 0 ? 0 : blue
    }
    
    func convertHexString() -> String {
        let redHex = String(format: "%02X", red)
        let greenHex = String(format: "%02X", green)
        let blueHex = String(format: "%02X", blue)
        
        return "0x\(redHex)\(greenHex)\(blueHex)"
    }
}
