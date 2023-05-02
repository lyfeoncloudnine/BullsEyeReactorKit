//
//  RecordViewReactor.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/05/02.
//

import Foundation

import ReactorKit

final class RecordViewReactor: Reactor {
    enum Action {
        case load
        case delete(Record)
    }
    
    enum Mutation {
        case setRecords([Record])
    }
    
    struct State {
        var records = [Record]()
    }
    
    let initialState = State()
    
    private let recordService: RecordServiceType
    
    init(recordService: RecordServiceType) {
        self.recordService = recordService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            let records = recordService.records()
            return .just(.setRecords(records))
            
        case .delete(let record):
            let records = recordService.delete(record: record)
            return .just(.setRecords(records))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setRecords(let records):
            newState.records = records
        }
        
        return newState
    }
}
