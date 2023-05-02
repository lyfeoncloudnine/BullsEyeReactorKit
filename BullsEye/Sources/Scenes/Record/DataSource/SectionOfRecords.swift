//
//  SectionOfRecords.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import Foundation

import RxDataSources

struct SectionOfRecords {
    var items: [Item]
}

extension SectionOfRecords: AnimatableSectionModelType {
    typealias Item = Record
    
    var identity: String {
        return "singleSection"
    }
    
    init(original: SectionOfRecords, items: [Record]) {
        self = original
        self.items = items
    }
}
