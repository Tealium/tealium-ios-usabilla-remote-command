//
//  UsabillaCommandRunnerTests.swift
//  RemoteCommandModulesTests
//
//  Created by Jonathan Wong on 4/2/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import XCTest
@testable import RemoteCommandModules
@testable import TealiumSwift

class UsabillaCommandRunnerTests: XCTestCase {

    let usabillaCommandRunner = MockUsabillaCommandRunner()
    var usabillaCommand: UsabillaCommand!
    var remoteCommand: TealiumRemoteCommand!
    
    override func setUp() {
        usabillaCommand = UsabillaCommand(usabillaCommandRunner: usabillaCommandRunner)
        remoteCommand = usabillaCommand.remoteCommand()
    }

    override func tearDown() {

    }

    func testInitializeNotCalledWithoutApiKey() {
        let expect = expectation(description: "test initialize")
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                       payload: [
                                                        "command_name": "initialize",
                                                        ])?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(0, usabillaCommandRunner.initializeCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }

    func testInitializeCalledWithAppId() {
        let expect = expectation(description: "test initialize")
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  payload: [
                                                    "command_name": "initialize",
                                                    "app_id": "test123"
                                                    ])?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(1, usabillaCommandRunner.initializeCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }

    func testSendEventCalledWithoutEvent() {
        let expect = expectation(description: "test initialize")
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  payload: [
                                                    "command_name": "initialize",
                                                    "app_id": "test123"
            ])?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(0, usabillaCommandRunner.sendEventCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testSendEventCalledWithEvent() {
        let expect = expectation(description: "test initialize")
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  payload: [
                                                    "command_name": "initialize, send_event",
                                                    "app_id": "test123",
                                                    "event_name": "my_event"
                                                    
            ])?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(1, usabillaCommandRunner.sendEventCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDisplayCampaignsNotCalledWithoutDisplayCampaignsKey() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,display_campaigns",
            "app_id": "test123"
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(0, usabillaCommandRunner.displayCampaignsCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDisplayCampaignsCalledWithDisplayCampaignsKey() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,display_campaigns",
            "app_id": "test123",
            "display_campaigns": true
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(1, usabillaCommandRunner.displayCampaignsCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testLoadFeedbackFormNotCalledWithoutKey() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,load_feedback_form",
            "app_id": "test123"
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(0, usabillaCommandRunner.loadFeedbackFormCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testLoadFeedbackFormCalledWithKey() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,load_feedback_form",
            "app_id": "test123",
            "form_id": "my_form_id"
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(1, usabillaCommandRunner.loadFeedbackFormCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testPreLoadFeedbackFormsNotCalledWithoutKey() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,preload_feedback_forms",
            "app_id": "test123",
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(0, usabillaCommandRunner.preloadFeedbackFormCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testPreLoadFeedbackFormsCalledWithKey() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,preload_feedback_forms",
            "app_id": "test123",
            "form_ids": ["form_1", "form_2"]
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(1, usabillaCommandRunner.preloadFeedbackFormCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testRemoveCachedFormsCalled() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,remove_cached_forms",
            "app_id": "test123",
            "form_ids": ["form_1", "form_2"]
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(1, usabillaCommandRunner.removeCachedFormsCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDismissAutomaticallyNotCalledWithoutKey() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,dismiss_automatically",
            "app_id": "test123",
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(0, usabillaCommandRunner.dismissAutomaticallyCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDismissAutomaticallyCalledWithKey() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,dismiss_automatically",
            "app_id": "test123",
            "dismiss_automatically": true
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(1, usabillaCommandRunner.dismissAutomaticallyCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testResetCalled() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,reset",
            "app_id": "test123",
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(1, usabillaCommandRunner.resetCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testSetCustomVariablesCalledWithKey() {
        let expect = expectation(description: "test initialize")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,set_custom_variables",
            "app_id": "test123",
            "custom.key1": "value1",
            "custom.key2": "value2",
            "custom.key3": "value3"
        ]
        if let response = HttpHelpers.httpRequest(commandId: "usabilla",
                                                  config: config,
                                                  payload: payload
            
            )?.description {
            let remoteCommandResponse = TealiumRemoteCommandResponse(urlString: response)
            if let response = remoteCommandResponse {
                remoteCommand.remoteCommandCompletion(response)
                
                XCTAssertEqual(1, usabillaCommandRunner.setCustomVariablesCallCount)
            }
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
}

class MockUsabillaCommandRunner: UsabillaCommandRunnable {
    
    var initializeCallCount = 0
    var sendEventCallCount = 0
    var resetCampaignDataCallCount = 0
    var loadFeedbackFormCallCount = 0
    var preloadFeedbackFormCallCount = 0
    var removeCachedFormsCallCount = 0
    var dismissAutomaticallyCallCount = 0
    var setCustomVariablesCallCount = 0
    var resetCallCount = 0
    var debugEnabledCallCount = 0
    var displayCampaignsCallCount = 0
    
    private var _debugEnabled: Bool = false
    var debugEnabled: Bool {
        get {
            return _debugEnabled
        }
        set(newValue) {
            _debugEnabled = newValue
            debugEnabledCallCount += 1
        }
    }
    
    
    private var _displayCampaigns: Bool = false
    var displayCampaigns: Bool {
        get {
            return _displayCampaigns
        }
        set(newValue) {
            _displayCampaigns = newValue
            displayCampaignsCallCount += 1
        }
    }
    
    func initialize(appID: String?) {
        initializeCallCount += 1
    }
    
    func initialize(appID: String?, completion: (() -> Void)?) {
        initializeCallCount += 1
    }
    
    func sendEvent(event: String) {
        sendEventCallCount += 1
    }
    
    func resetCampaignData(completion: (() -> Void)?) {
        resetCampaignDataCallCount += 1
    }
    
    func loadFeedbackForm(formID: String) {
        loadFeedbackFormCallCount += 1
    }
    
    func preloadFeedbackForms(with formIDs: [String]) {
        preloadFeedbackFormCallCount += 1
    }
    
    func removeCachedForms() {
        removeCachedFormsCallCount += 1
    }
    
    func dismissAutomatically(_ automatic: Bool) {
        dismissAutomaticallyCallCount += 1
    }
    
    func setCustomVariables(_ customVariables: [String : Any]) {
        setCustomVariablesCallCount += 1
    }
    
    func reset() {
        resetCallCount += 1
    }
    
    
}
