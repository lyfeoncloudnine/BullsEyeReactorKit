//
//  RecordServiceType.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import Foundation

protocol RecordServiceType {
    func records() -> [Record]
    @discardableResult func create(record: Record) -> [Record]
    func delete(record: Record) -> [Record]
    func clear()
}
