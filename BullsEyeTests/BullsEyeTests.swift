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
                var record = Record(name: "guest", score: 100)
                
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
}
