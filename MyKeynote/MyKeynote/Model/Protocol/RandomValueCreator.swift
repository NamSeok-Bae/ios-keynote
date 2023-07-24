//
//  RandomValueCreator.swift
//  MyKeynote
//
//  Created by 배남석 on 2023/07/17.
//

import Foundation

protocol RandomValueCreator {
    func createRandomIdentifier() -> String
    func createRandomInt(range: ClosedRange<Int>) -> Int
    func createRandomColor() -> SlideColor
}

extension RandomValueCreator {
    func createRandomIdentifier() -> String {
        var randomValueArray: [String] = []
        
        for _ in 0..<3 {
            var randomValue = ""
            for _ in 0..<3 {
                let randomAsciiNumber = [createRandomInt(range: 48...57),
                                         createRandomInt(range: 97...122)].randomElement() ?? 48
                let string = String(UnicodeScalar(randomAsciiNumber)!)
                randomValue.append(string)
            }
            randomValueArray.append(randomValue)
        }
        
        return randomValueArray.joined(separator: "-")
    }
    
    func createRandomInt(range: ClosedRange<Int>) -> Int {
        return Int.random(in: range)
    }
    
    func createRandomColor() -> SlideColor {
        return SlideColor(red: createRandomInt(range: 0...255),
                     green: createRandomInt(range: 0...255),
                     blue: createRandomInt(range: 0...255))
    }
}
