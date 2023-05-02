//
//  GameViewReactorTests.swift
//  BullsEyeTests
//
//  Created by lyfeoncloudnine on 2023/05/03.
//

import XCTest
import Quick

@testable import BullsEye

final class GameViewReactorTests: QuickSpec {
    override func spec() {
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
}
