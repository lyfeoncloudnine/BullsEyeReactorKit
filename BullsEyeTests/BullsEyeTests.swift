//
//  BullsEyeTests.swift
//  BullsEyeTests
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

import XCTest
import Quick

@testable import BullsEye

final class BullsEyeTests: QuickSpec {
    override func spec() {
        recordServiceTests()
        gameViewReactorTests()
        recordViewReactorTests()
    }
}

private extension BullsEyeTests {
    func recordServiceTests() {
        describe("RecordService Tests") {
            var recordService: RecordServiceType!
            
            beforeEach {
                recordService = RecordService()
            }
            
            context("저장된 기록이 없으면") {
                it("records()는 빈 값이다") {
                    XCTAssertTrue(recordService.records().isEmpty)
                }
            }
            
            context("저장된 기록이 있으면") {
                var records: [Record]!
                let record = Record(targetNumber: 100, score: 100)
                
                beforeEach {
                    records = recordService.create(record: record)
                }
                
                afterEach {
                    recordService.clear()
                }
                
                it("records()는 빈 값이 아니다") {
                    XCTAssertFalse(records.isEmpty)
                }
                
                it("기록을 지울 수 있다") {
                    records = recordService.delete(record: record)
                    XCTAssertTrue(records.isEmpty)
                }
            }
        }
    }
    
    func gameViewReactorTests() {
        describe("GameViewReactor Tests") {
            var recordService: RecordServiceType!
            var gameViewReactor: GameViewReactor!
            
            beforeEach {
                recordService = RecordService()
                gameViewReactor = GameViewReactor(recordService: recordService)
            }
            
            context("GameViewReactor가 초기화하면") {
                it("round는 1이다") {
                    XCTAssertEqual(gameViewReactor.currentState.round, 1)
                }
                
                it("score는 100이다") {
                    XCTAssertEqual(gameViewReactor.currentState.score, 100)
                }
                
                it("isPlaying은 false다") {
                    XCTAssertFalse(gameViewReactor.currentState.isPlaying)
                }
                
                it("targetNumber는 nil이다") {
                    XCTAssertNil(gameViewReactor.currentState.targetNumber)
                }
                
                it("expectNumber는 50이다") {
                    XCTAssertEqual(gameViewReactor.currentState.expectNumber, 50)
                }
            }
            
            context("게임을 시작하면") {
                beforeEach {
                    gameViewReactor.action.onNext(.play)
                }
                
                it("round는 1이다") {
                    XCTAssertEqual(gameViewReactor.currentState.round, 1)
                }
                
                it("score는 100이다") {
                    XCTAssertEqual(gameViewReactor.currentState.score, 100)
                }
                
                it("isPlaying은 true다") {
                    XCTAssertTrue(gameViewReactor.currentState.isPlaying)
                }
                
                it("targetNumber는 nil이 아니다") {
                    XCTAssertNotNil(gameViewReactor.currentState.targetNumber)
                }
                
                it("expectNumber는 50이다") {
                    XCTAssertEqual(gameViewReactor.currentState.expectNumber, 50)
                }
                
                context("정답을 못맞추면") {
                    beforeEach {
                        gameViewReactor.action.onNext(.changeExpectNumber(0))
                        gameViewReactor.action.onNext(.check)
                    }
                    
                    it("round는 2이다") {
                        XCTAssertEqual(gameViewReactor.currentState.round, 2)
                    }
                    
                    it("score는 99다") {
                        XCTAssertEqual(gameViewReactor.currentState.score, 99)
                    }
                    
                    it("expectNumber는 50이다") {
                        XCTAssertEqual(gameViewReactor.currentState.expectNumber, 50)
                    }
                }
                
                context("정답을 맞추면") {
                    beforeEach {
                        gameViewReactor.action.onNext(.changeExpectNumber(Float(gameViewReactor.currentState.targetNumber!)))
                        gameViewReactor.action.onNext(.check)
                    }
                    
                    afterEach {
                        recordService.clear()
                    }
                    
                    it("round는 1이다") {
                        XCTAssertEqual(gameViewReactor.currentState.round, 1)
                    }
                    
                    it("score는 100이다") {
                        XCTAssertEqual(gameViewReactor.currentState.score, 100)
                    }
                    
                    it("isPlaying은 false다") {
                        XCTAssertFalse(gameViewReactor.currentState.isPlaying)
                    }
                }
            }
        }
    }
    
    func recordViewReactorTests() {
        describe("RecordViewReactor Tests") {
            var recordService: RecordServiceType!
            var recordViewReactor: RecordViewReactor!
            
            beforeEach {
                recordService = RecordService()
                recordViewReactor = RecordViewReactor(recordService: recordService)
            }
            
            context("기록이 없으면") {
                it("records가 비어있다") {
                    recordViewReactor.action.onNext(.load)
                    XCTAssertTrue(recordViewReactor.currentState.records.isEmpty)
                }
            }
            
            context("기록이 있으면") {
                let record = Record(targetNumber: 100, score: 100)
                beforeEach {
                    recordService.create(record: record)
                    recordViewReactor.action.onNext(.load)
                }
                
                afterEach {
                    recordService.clear()
                }
                
                it("records가 존재한다") {
                    XCTAssertFalse(recordViewReactor.currentState.records.isEmpty)
                }
                
                it("기록을 지울 수 있다") {
                    recordViewReactor.action.onNext(.delete(record))
                    XCTAssertTrue(recordViewReactor.currentState.records.isEmpty)
                }
            }
        }
    }
}
