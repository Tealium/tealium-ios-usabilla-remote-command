//
//  UsabillaInstanceTests.swift
//  TealiumUsabillaTests
//
//  Copyright © 2019 Tealium. All rights reserved.
//

import XCTest
@testable import TealiumUsabilla

class UsabillaInstanceTests: XCTestCase {

    let usabillaInstance = MockUsabillaInstance()
    var usabillaCommand: UsabillaRemoteCommand!
    
    override func setUp() {
        usabillaCommand = UsabillaRemoteCommand(usabillaInstance: usabillaInstance)
    }

    // MARK: Webview Remote Command Tests
    
    func testInitializeCalledWithAppId() {
        let expect = expectation(description: "initialize has been called")
        let payload = ["command_name": "initialize", "appId": "test123"]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.initializeCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testInitializeCalledWithAppIdAndDebug() {
        let expect = expectation(description: "initialize has been called")
        let payload: [String: Any] = ["command_name": "initialize", "appId": "test123", "debugEnabled": true]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.initializeCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }

    func testInitializeNotCalledWithoutAppId() {
        let expect = expectation(description: "initialize was not called")
        let payload = ["command_name": "initialize"]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.initializeCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testSendEventCalledWithoutEvent() {
        let expect = expectation(description: "sendEvent was not called")
        let payload = ["command_name": "initialize,sendevent", "app_id": "test123"]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.sendEventCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testSendEventCalledWithEvent() {
        let expect = expectation(description: "sendEvent has been called")
        let payload = ["command_name": "initialize,sendevent", "app_id": "test123", "event": "my_event"]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.sendEventCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDisplayCampaignsNotCalledWithoutDisplayCampaignsKey() {
        let expect = expectation(description: "displayCampaigns was not called")
        let payload: [String: Any] = [
            "command_name": "initialize,display_campaigns",
            "app_id": "test123"
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.displayCampaignsCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDisplayCampaignsCalledWithDisplayCampaignsKey() {
        let expect = expectation(description: "displayCampaigns has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,candisplaycampaigns",
            "appId": "test123",
            "canDisplayCampaigns": true
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.displayCampaignsCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testLoadFeedbackFormNotCalledWithoutKey() {
        let expect = expectation(description: "loadFeedbackForm was not called")
        let payload: [String: Any] = [
            "command_name": "initialize,loadfeedbackform",
            "appId": "test123"
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.loadFeedbackFormCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testLoadFeedbackFormCalledWithKey() {
        let expect = expectation(description: "loadFeedbackForm has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,loadfeedbackform",
            "appId": "test123",
            "formId": "my_form_id"
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.loadFeedbackFormCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testPreLoadFeedbackFormsNotCalledWithoutKey() {
        let expect = expectation(description: "preloadFeedbackForm was not called")
        let payload: [String: Any] = [
            "command_name": "initialize,preloadfeedbackforms",
            "appId": "test123",
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.preloadFeedbackFormCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testPreLoadFeedbackFormsCalledWithKey() {
        let expect = expectation(description: "preloadFeedbackForm has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,preloadfeedbackforms",
            "appId": "test123",
            "formIds": ["form_1", "form_2"]
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.preloadFeedbackFormCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testRemoveCachedFormsCalled() {
        let expect = expectation(description: "removeCachedForms has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,removecachedforms",
            "appId": "test123",
            "formIds": ["form_1", "form_2"]
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.removeCachedFormsCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDismissAutomaticallyNotCalledWithoutKey() {
        let expect = expectation(description: "dismissAutomatically was not called")
        let payload: [String: Any] = [
            "command_name": "initialize,dismissautomatically",
            "appId": "test123",
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.dismissAutomaticallyCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDismissAutomaticallyCalledWithKey() {
        let expect = expectation(description: "dismissAutomatically has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,dismissautomatically",
            "appId": "test123",
            "dismissAutomatically": true
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.dismissAutomaticallyCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testResetCalled() {
        let expect = expectation(description: "reset has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,resetcampaigndata",
            "appId": "test123",
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.resetCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testSetCustomVariablesCalledWithKey() {
        let expect = expectation(description: "setCustomVariables has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,setcustomvariable",
            "appId": "test123",
            "custom": ["key": "value1", "key2": "value2", "key3": "value3"]
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .webview, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.setCustomVariablesCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    // MARK: JSON Remote Command Tests
    
    func testInitializeCalledWithAppIdJSON() {
        let expect = expectation(description: "initialize has been called")
        let payload = ["command_name": "initialize", "appId": "test123"]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.initializeCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testInitializeCalledWithAppIdAndDebugJSON() {
        let expect = expectation(description: "initialize has been called")
        let payload: [String: Any] = ["command_name": "initialize", "appId": "test123", "debugEnabled": true]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.initializeCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }

    func testInitializeNotCalledWithoutAppIdJSON() {
        let expect = expectation(description: "initialize was not called")
        let payload = ["command_name": "initialize"]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.initializeCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testSendEventCalledWithoutEventJSON() {
        let expect = expectation(description: "sendEvent was not called")
        let payload = ["command_name": "initialize,sendevent", "app_id": "test123"]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.sendEventCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testSendEventCalledWithEventJSON() {
        let expect = expectation(description: "sendEvent has been called")
        let payload = ["command_name": "initialize,sendevent", "app_id": "test123", "event": "my_event"]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.sendEventCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDisplayCampaignsNotCalledWithoutDisplayCampaignsKeyJSON() {
        let expect = expectation(description: "displayCampaigns was not called")
        let payload: [String: Any] = [
            "command_name": "initialize,display_campaigns",
            "app_id": "test123"
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.displayCampaignsCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDisplayCampaignsCalledWithDisplayCampaignsKeyJSON() {
        let expect = expectation(description: "displayCampaigns has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,candisplaycampaigns",
            "appId": "test123",
            "canDisplayCampaigns": true
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.displayCampaignsCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testLoadFeedbackFormNotCalledWithoutKeyJSON() {
        let expect = expectation(description: "loadFeedbackForm was not called")
        let payload: [String: Any] = [
            "command_name": "initialize,loadfeedbackform",
            "appId": "test123"
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.loadFeedbackFormCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testLoadFeedbackFormCalledWithKeyJSON() {
        let expect = expectation(description: "loadFeedbackForm has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,loadfeedbackform",
            "appId": "test123",
            "formId": "my_form_id"
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.loadFeedbackFormCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testPreLoadFeedbackFormsNotCalledWithoutKeyJSON() {
        let expect = expectation(description: "preloadFeedbackForm was not called")
        let payload: [String: Any] = [
            "command_name": "initialize,preloadfeedbackforms",
            "appId": "test123",
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.preloadFeedbackFormCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testPreLoadFeedbackFormsCalledWithKeyJSON() {
        let expect = expectation(description: "preloadFeedbackForm has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,preloadfeedbackforms",
            "appId": "test123",
            "formIds": ["form_1", "form_2"]
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.preloadFeedbackFormCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testRemoveCachedFormsCalledJSON() {
        let expect = expectation(description: "removeCachedForms has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,removecachedforms",
            "appId": "test123",
            "formIds": ["form_1", "form_2"]
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.removeCachedFormsCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDismissAutomaticallyNotCalledWithoutKeyJSON() {
        let expect = expectation(description: "dismissAutomatically was not called")
        let payload: [String: Any] = [
            "command_name": "initialize,dismissautomatically",
            "appId": "test123",
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(0, usabillaInstance.dismissAutomaticallyCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testDismissAutomaticallyCalledWithKeyJSON() {
        let expect = expectation(description: "dismissAutomatically has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,dismissautomatically",
            "appId": "test123",
            "dismissAutomatically": true
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.dismissAutomaticallyCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testResetCalledJSON() {
        let expect = expectation(description: "reset has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,resetcampaigndata",
            "appId": "test123",
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.resetCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
    
    func testSetCustomVariablesCalledWithKeyJSON() {
        let expect = expectation(description: "setCustomVariables has been called")
        let payload: [String: Any] = [
            "command_name": "initialize,setcustomvariable",
            "appId": "test123",
            "custom": ["key": "value1", "key2": "value2", "key3": "value3"]
        ]
        if let response = HttpTestHelpers.createRemoteCommandResponse(type: .JSON, commandId: "usabilla", payload: payload) {
            usabillaCommand.completion(response)
            XCTAssertEqual(1, usabillaInstance.setCustomVariablesCallCount)
            expect.fulfill()
        }
        wait(for: [expect], timeout: 2.0)
    }
}

class MockUsabillaInstance: UsabillaCommand {

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
    
    func initialize(appID: String?, debug: Bool) {
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
