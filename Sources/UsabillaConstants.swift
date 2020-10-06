//
//  UsabillaConstants.swift
//  TealiumUsabilla
//
//  Copyright © 2020 Tealium. All rights reserved.
//

import Foundation

public enum UsabillaConstants {
    
    static let commandName = "command_name"
    static let separator: Character = ","
    static let commandId = "usabilla"
    static let description = "Usabilla Remote Command"
    
    enum Keys {
        static let appID = "appId"
        static let event = "event"
        static let debugEnabled = "debugEnabled"
        static let displayCampaigns = "canDisplayCampaigns"
        static let formID = "formId"
        static let formIDs = "formIds"
        static let dismissAutomatically = "dismissAutomatically"
        static let customPrefix = "custom"
    }
    
    enum Commands: String {
        case initialize = "initialize"
        case sendEvent = "sendevent"
        case debugEnabled = "debugenabled"
        case displayCampaigns = "candisplaycampaigns"
        case loadFeedbackForm = "loadfeedbackform"
        case preloadFeedbackForms = "preloadfeedbackforms"
        case removeCachedForms = "removecachedforms"
        case dismissAutomatically = "dismissautomatically"
        case setCustomVariables = "setcustomvariable"
        case reset = "resetcampaigndata"
    }

}
