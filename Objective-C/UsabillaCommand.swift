//
//  UsabillaCommand.swift
//  RemoteCommandModules
//
//  Created by Jonathan Wong on 4/2/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import UIKit
import Usabilla
import TealiumIOS

public class UsabillaCommand: NSObject {
    
    enum UsabillaCommand {
        static let initialize = "initialize"
        static let sendEvent = "sendevent"
        static let debugEnabled = "debugenabled"
        static let displayCampaigns = "candisplaycampaigns"
        static let loadFeedbackForm = "loadfeedbackform"
        static let preloadFeedbackForms = "preloadfeedbackforms"
        static let removeCachedForms = "removecachedforms"
        static let dismissAutomatically = "dismissautomatically"
        static let setCustomVariables = "setcustomvariable"
        static let reset = "resetcampaigndata"
    }
    
    enum UsabillaKey {
        static let appID = "appId"
        static let event = "event"
        static let debugEnabled = "debugEnabled"
        static let displayCampaigns = "canDisplayCampaigns"
        static let formID = "formId"
        static let formIDs = "formIds"
        static let dismissAutomatically = "dismissAutomatically"
        static let customPrefix = "custom"
        static let command = "command_name"
    }
    
    var usabillaTracker: UsabillaTrackable
    
    @objc
    public init(usabillaTracker: UsabillaTrackable = UsabillaTracker()) {
        self.usabillaTracker = usabillaTracker
    }
    
    @objc
    public func remoteCommand() -> TEALRemoteCommandResponseBlock {
        return { response in
            guard let payload = response?.requestPayload as? [String: Any] else {
                return
            }
            guard let command = payload[UsabillaKey.command] as? String else {
                return
            }
            
            let commands = command.split(separator: ",")
            let usabillaCommands = commands.map { command in
                return command.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            
            self.parseCommands(usabillaCommands, payload: payload)
            
        }
    }
    
    public func parseCommands(_ commands: [String], payload: [String: Any]) {
        commands.forEach { [weak self] command in
            let lowercasedCommand = command.lowercased()
            switch lowercasedCommand {
            case UsabillaCommand.initialize:
                guard let appID = payload[UsabillaKey.appID] as? String else {
                    return
                }
                self?.usabillaTracker.initialize(appID: appID)
            case UsabillaCommand.sendEvent:
                guard let event = payload[UsabillaKey.event] as? String else {
                    return
                }
                self?.usabillaTracker.sendEvent(event: event)
            case UsabillaCommand.displayCampaigns:
                guard let displayCampaigns = payload[UsabillaKey.displayCampaigns] as? Bool else {
                    return
                }
                self?.usabillaTracker.displayCampaigns = displayCampaigns
            case UsabillaCommand.loadFeedbackForm:
                guard let formID = payload[UsabillaKey.formID] as? [String] else {
                    return
                }
                self?.usabillaTracker.loadFeedbackForm(formID: formID[0])
            case UsabillaCommand.preloadFeedbackForms:
                guard let formIDs = payload[UsabillaKey.formIDs] as? [String] else {
                    return
                }
                self?.usabillaTracker.preloadFeedbackForms(with: formIDs)
            case UsabillaCommand.removeCachedForms:
                self?.usabillaTracker.removeCachedForms()
            case UsabillaCommand.dismissAutomatically:
                guard let customVariables = payload[UsabillaKey.customPrefix] as? [String: Any], let automatic = customVariables[UsabillaKey.dismissAutomatically] as? Int else {
                    return
                }
                
                let dismiss = automatic == 1 ? true : false
                self?.usabillaTracker.dismissAutomatically(dismiss)
            case UsabillaCommand.setCustomVariables:
                let customVariables = payload.filter { key, value in
                    key.starts(with: UsabillaKey.customPrefix)
                }
                self?.usabillaTracker.setCustomVariables(customVariables)
            case UsabillaCommand.reset:
                self?.usabillaTracker.reset()
            default:
                break
            }
            
        }
    }
}
