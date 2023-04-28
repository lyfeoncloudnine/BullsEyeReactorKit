//
//  RecordService.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import Foundation

struct RecordService: RecordServiceType {
    private let userDefaults = UserDefaults.standard
    private let key = "recordServiceKey"
    
    func records() -> [Record] {
        if let data = userDefaults.data(forKey: key), let records = try? PropertyListDecoder().decode([Record].self, from: data) {
            return records
        } else {
            return []
        }
    }
    
    func create(record: Record) -> [Record] {
        var records = records()
        records.append(record)
        records.sort { $0.score > $1.score }
        
        userDefaults.set(try? PropertyListEncoder().encode(records), forKey: key)
        
        return records
    }
    
    func delete(record: Record) -> [Record] {
        var records = records()
        
        guard records.isEmpty == false else { return records }
        guard let index = records.firstIndex(where: { $0.id == record.id }) else { return records }
        
        records.remove(at: index)
        userDefaults.set(try? PropertyListEncoder().encode(records), forKey: key)
        
        return records
    }
    
    func clear() {
        userDefaults.set(nil, forKey: key)
    }
}

private extension RecordService {
    
}
