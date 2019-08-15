//
//  UsabillaCommand.swift
//  RemoteCommandModules
//
//  Created by Jonathan Wong on 4/2/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import UIKit
import Usabilla
#if COCOAPODS
import TealiumSwift
#else
import TealiumCore
import TealiumTagManagement
import TealiumRemoteCommands
#endif

public class UsabillaCommand {
    
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
    }
    
    var usabillaCommandRunner: UsabillaCommandRunnable
    
    public init(usabillaCommandRunner: UsabillaCommandRunnable = UsabillaCommandRunner()) {
        self.usabillaCommandRunner = usabillaCommandRunner
    }
    
    public func remoteCommand() -> TealiumRemoteCommand {
        return TealiumRemoteCommand(commandId: "usabilla", description: "Usabilla Remote Command") { response in
            let payload = response.payload()
            guard let command = payload[TealiumRemoteCommand.commandName] as? String else {
                return
            }
            
            let commands = command.split(separator: ",")
            let usabillaCommands = commands.map { command in
                return command.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            }
            
            usabillaCommands.forEach { [weak self] command in
                let lowercasedCommand = command.lowercased()
                switch lowercasedCommand {
                case UsabillaCommand.initialize:
                    guard let appID = payload[UsabillaKey.appID] as? String else {
                        return
                    }
                    self?.usabillaCommandRunner.initialize(appID: appID)
                case UsabillaCommand.sendEvent:
                    guard let event = payload[UsabillaKey.event] as? String else {
                        return
                    }
                    self?.usabillaCommandRunner.sendEvent(event: event)
                case UsabillaCommand.displayCampaigns:
                    guard let displayCampaigns = payload[UsabillaKey.displayCampaigns] as? Bool else {
                        return
                    }
                    self?.usabillaCommandRunner.displayCampaigns = displayCampaigns
                case UsabillaCommand.loadFeedbackForm:
                    guard let formID = payload[UsabillaKey.formID] as? [String] else {
                        return
                    }
                    self?.usabillaCommandRunner.loadFeedbackForm(formID: formID[0])
                case UsabillaCommand.preloadFeedbackForms:
                    guard let formIDs = payload[UsabillaKey.formIDs] as? [String] else {
                        return
                    }
                    self?.usabillaCommandRunner.preloadFeedbackForms(with: formIDs)
                case UsabillaCommand.removeCachedForms:
                    self?.usabillaCommandRunner.removeCachedForms()
                case UsabillaCommand.dismissAutomatically:
                    guard let customVariables = payload[UsabillaKey.customPrefix] as? [String: Any], let automatic = customVariables[UsabillaKey.dismissAutomatically] as? Int else {
                        return
                    }
                    
                    let dismiss = automatic == 1 ? true : false
                    self?.usabillaCommandRunner.dismissAutomatically(dismiss)
                case UsabillaCommand.setCustomVariables:
                    let customVariables = payload.filter { key, value in
                        key.starts(with: UsabillaKey.customPrefix)
                    }
                    self?.usabillaCommandRunner.setCustomVariables(customVariables)
                case UsabillaCommand.reset:
                    self?.usabillaCommandRunner.reset()
                default:
                    break
                }
                
            }
        }
    }
}

extension TealiumRemoteCommand {
    static let commandName = "command_name"
}
