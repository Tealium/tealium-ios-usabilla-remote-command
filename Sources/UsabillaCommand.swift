//
//  UsabillaCommand.swift
//  RemoteCommandModules
//
//  Created by Jonathan Wong on 4/2/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import UIKit
import TealiumSwift
import Usabilla

class UsabillaCommand {
    
    enum UsabillaCommand {
        static let initialize = "initialize"
        static let sendEvent = "send_event"
        static let debugEnabled = "debug_enabled"
        static let displayCampaigns = "display_campaigns"
        static let loadFeedbackForm = "load_feedback_form"
        static let preloadFeedbackForms = "preload_feedback_forms"
        static let removeCachedForms = "remove_cached_forms"
        static let dismissAutomatically = "dismiss_automatically"
        static let setCustomVariables = "set_custom_variables"
        static let reset = "reset"
    }
    
    enum UsabillaKey {
        static let appID = "app_id"
        static let event = "event_name"
        static let debugEnabled = "debug_enabled"
        static let displayCampaigns = "display_campaigns"
        static let formID = "form_id"
        static let formIDs = "form_ids"
        static let dismissAutomatically = "dismiss_automatically"
        static let customPrefix = "custom."
    }
    
    var usabillaCommandRunner: UsabillaCommandRunnable
    
    init(usabillaCommandRunner: UsabillaCommandRunnable) {
        self.usabillaCommandRunner = usabillaCommandRunner
    }
    
    func remoteCommand() -> TealiumRemoteCommand {
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
                    guard let formID = payload[UsabillaKey.formID] as? String else {
                        return
                    }
                    self?.usabillaCommandRunner.loadFeedbackForm(formID: formID)
                case UsabillaCommand.preloadFeedbackForms:
                    guard let formIDs = payload[UsabillaKey.formIDs] as? [String] else {
                        return
                    }
                    self?.usabillaCommandRunner.preloadFeedbackForms(with: formIDs)
                case UsabillaCommand.removeCachedForms:
                    self?.usabillaCommandRunner.removeCachedForms()
                case UsabillaCommand.dismissAutomatically:
                    guard let automatic = payload[UsabillaKey.dismissAutomatically] as? Bool else {
                        return
                    }
                    self?.usabillaCommandRunner.dismissAutomatically(automatic)
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
