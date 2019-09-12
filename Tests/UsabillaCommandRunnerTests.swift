//
//  UsabillaCommandRunnerTests.swift
//  RemoteCommandModulesTests
//
//  Created by Jonathan Wong on 4/2/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import XCTest
@testable import TealiumUsabilla
import TealiumRemoteCommands

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
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
                                                  payload: [
                                                    "command_name": "initialize",
                                                    "appId": "test123"
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
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
        let expect = expectation(description: "test send event called with event")
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
                                                  payload: [
                                                    "command_name": "initialize, sendevent",
                                                    "appId": "test123",
                                                    "event": "my_event"
                                                    
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
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
            "command_name": "initialize,candisplaycampaigns",
            "appId": "test123",
            "canDisplayCampaigns": true
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
            "command_name": "initialize,loadfeedbackform",
            "appId": "test123"
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
        let expect = expectation(description: "test load feedback form called with form id")
        let config: [String: Any] = ["response_id": "1234"]
        let payload: [String: Any] = [
            "command_name": "initialize,loadfeedbackform",
            "appId": "test123",
            "formId": "my_form_id"
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
            "command_name": "initialize,preloadfeedbackforms",
            "appId": "test123",
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
            "command_name": "initialize,preloadfeedbackforms",
            "appId": "test123",
            "formIds": ["form_1", "form_2"]
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
            "command_name": "initialize,removecachedforms",
            "appId": "test123",
            "formIds": ["form_1", "form_2"]
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
            "command_name": "initialize,dismissautomatically",
            "appId": "test123",
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
            "command_name": "initialize,dismissautomatically",
            "appId": "test123",
            "dismissAutomatically": true
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
            "command_name": "initialize,resetcampaigndata",
            "appId": "test123",
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
            "command_name": "initialize,setcustomvariable",
            "appId": "test123",
            "custom": ["key": "value1", "key2": "value2", "key3": "value3"]
        ]
        if let response = HttpTestHelpers.httpRequest(commandId: "usabilla",
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
