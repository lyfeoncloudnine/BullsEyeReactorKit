//
//  Record.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import Foundation

struct Record: Codable, Equatable {
    let id: String
    let targetNumber: Int
    let score: Int
    
    init(id: String = UUID().uuidString, targetNumber: Int, score: Int) {
        self.id = id
        self.targetNumber = targetNumber
        self.score = score
    }
}
