//
//  GameViewReactor.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import Foundation

import ReactorKit

final class GameViewReactor: Reactor {
    enum Action {
        case play
        case changeExpectNumber(Float)
        case check
    }
    
    enum Mutation {
        case setPlay
        case setExpectNumber(Float)
        case keepPlaying
        case finish
    }
    
    struct State {
        var isPlaying = false
        var round = 1
        var score = 100
        var targetNumber: Int?
        var expectNumber: Float = 50
        var title = "BullsEye 🎯"
        @Pulse var alertMessage: String?
    }
    
    let initialState = State()
    
    private let recordService: RecordServiceType
    
    init(recordService: RecordServiceType) {
        self.recordService = recordService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .play:
            return .just(.setPlay)
            
        case .changeExpectNumber(let expectNumber):
            return .just(.setExpectNumber(expectNumber))
            
        case .check:
            if let targetNumber = currentState.targetNumber, targetNumber == Int(currentState.expectNumber.rounded()) {
                recordService.create(record: Record(targetNumber: targetNumber, score: currentState.score))
                return .just(.finish)
            } else {
                return .just(.keepPlaying)
            }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setPlay:
            newState.isPlaying = true
            newState.round = 1
            newState.score = 100
            newState.targetNumber = Int.random(in: 1...100)
            newState.expectNumber = 50
            
        case .setExpectNumber(let expectNumber):
            newState.expectNumber = expectNumber
            
        case .keepPlaying:
            newState.alertMessage = retryMessage(state: newState)
            newState.round += 1
            newState.score -= 1
            newState.expectNumber = 50
            
        case .finish:
            newState.isPlaying = false
            newState.alertMessage = endMessage(state: newState)
        }
        
        return newState
    }
}

private extension GameViewReactor {
    func endMessage(state: State) -> String {
        """
        🎊축하합니다!🎊
        \(state.round)회만에 정답을 맞히셨네요!
        점수는 \(state.score)점이에요!
        """
    }
    
    func retryMessage(state: State) -> String {
        guard let targetNumber = state.targetNumber else { fatalError("targetNumber is must not nil") }
        let expectNumber = Int(state.expectNumber.rounded())
        let diff = abs(targetNumber - expectNumber)
        return """
        😓아쉬워요😓
        정답과 차이는 \(diff)에요.
        다시 한 번 시도해 보세요!
        """
    }
}

extension GameViewReactor {
    func createRecordViewReactor() -> RecordViewReactor {
        RecordViewReactor(recordService: recordService)
    }
}
