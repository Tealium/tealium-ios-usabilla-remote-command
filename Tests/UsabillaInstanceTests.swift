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
    
    func testInitializeCalledWithAppId() {
        let payload = ["command_name": "initialize", "appId": "test123"]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.initializeCallCount)
    }
    
    func testInitializeCalledWithAppIdAndDebug() {
        let payload: [String: Any] = ["command_name": "initialize", "appId": "test123", "debugEnabled": true]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.initializeCallCount)
    }

    func testInitializeNotCalledWithoutAppId() {
        let payload = ["command_name": "initialize"]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(0, usabillaInstance.initializeCallCount)
    }
    
    func testSendEventCalledWithoutEvent() {
        let payload = ["command_name": "initialize,sendevent", "app_id": "test123"]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(0, usabillaInstance.sendEventCallCount)
    }
    
    func testSendEventCalledWithEvent() {
        let payload = ["command_name": "initialize,sendevent", "app_id": "test123", "event": "my_event"]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.sendEventCallCount)
    }
    
    func testDisplayCampaignsNotCalledWithoutDisplayCampaignsKey() {
        let payload: [String: Any] = [
            "command_name": "initialize,display_campaigns",
            "app_id": "test123"
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(0, usabillaInstance.displayCampaignsCallCount)
    }
    
    func testDisplayCampaignsCalledWithDisplayCampaignsKey() {
        let payload: [String: Any] = [
            "command_name": "initialize,candisplaycampaigns",
            "appId": "test123",
            "canDisplayCampaigns": true
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.displayCampaignsCallCount)
    }
    
    func testLoadFeedbackFormNotCalledWithoutKey() {
        let payload: [String: Any] = [
            "command_name": "initialize,loadfeedbackform",
            "appId": "test123"
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(0, usabillaInstance.loadFeedbackFormCallCount)
    }
    
    func testLoadFeedbackFormCalledWithKey() {
        let payload: [String: Any] = [
            "command_name": "initialize,loadfeedbackform",
            "appId": "test123",
            "formId": "my_form_id"
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.loadFeedbackFormCallCount)
    }
    
    func testPreLoadFeedbackFormsNotCalledWithoutKey() {
        let payload: [String: Any] = [
            "command_name": "initialize,preloadfeedbackforms",
            "appId": "test123",
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(0, usabillaInstance.preloadFeedbackFormCallCount)
    }
    
    func testPreLoadFeedbackFormsCalledWithKey() {
        let payload: [String: Any] = [
            "command_name": "initialize,preloadfeedbackforms",
            "appId": "test123",
            "formIds": ["form_1", "form_2"]
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.preloadFeedbackFormCallCount)
    }
    
    func testRemoveCachedFormsCalled() {
        let payload: [String: Any] = [
            "command_name": "initialize,removecachedforms",
            "appId": "test123",
            "formIds": ["form_1", "form_2"]
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.removeCachedFormsCallCount)
    }
    
    func testDismissAutomaticallyNotCalledWithoutKey() {
        let payload: [String: Any] = [
            "command_name": "initialize,dismissautomatically",
            "appId": "test123",
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(0, usabillaInstance.dismissAutomaticallyCallCount)
    }
    
    func testDismissAutomaticallyCalledWithKey() {
        let payload: [String: Any] = [
            "command_name": "initialize,dismissautomatically",
            "appId": "test123",
            "dismissAutomatically": true
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.dismissAutomaticallyCallCount)
    }
    
    func testResetCalled() {
        let payload: [String: Any] = [
            "command_name": "initialize,resetcampaigndata",
            "appId": "test123",
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.resetCallCount)
    }
    
    func testSetCustomVariablesCalledWithKey() {
        let payload: [String: Any] = [
            "command_name": "initialize,setcustomvariable",
            "appId": "test123",
            "custom": ["key": "value1", "key2": "value2", "key3": "value3"]
        ]
        usabillaCommand.processRemoteCommand(with: payload)
        XCTAssertEqual(1, usabillaInstance.setCustomVariablesCallCount)
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
