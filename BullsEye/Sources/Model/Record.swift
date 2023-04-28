//
//  Record.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import Foundation

struct Record: Codable {
    let id: String
    let name: String
    let score: Int
    
    init(id: String = UUID().uuidString, name: String, score: Int) {
        self.id = id
        self.name = name
        self.score = score
    }
}
