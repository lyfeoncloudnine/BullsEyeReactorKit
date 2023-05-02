//
//  Record.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import Foundation

import RxDataSources

struct Record: Codable, Equatable, IdentifiableType {
    let identity: String
    let targetNumber: Int
    let score: Int
    
    init(identity: String = UUID().uuidString, targetNumber: Int, score: Int) {
        self.identity = identity
        self.targetNumber = targetNumber
        self.score = score
    }
}
