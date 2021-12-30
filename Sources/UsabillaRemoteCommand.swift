//
//  UsabillaRemoteCommand.swift
//  TealiumUsabilla
//
//  Copyright © 2019 Tealium. All rights reserved.
//

import UIKit
import Usabilla
#if COCOAPODS
import TealiumSwift
#else
import TealiumCore
import TealiumRemoteCommands
#endif

public class UsabillaRemoteCommand: RemoteCommand {
    
    var usabillaInstance: UsabillaCommand?

    public init(usabillaInstance: UsabillaCommand = UsabillaInstance(),
                type: RemoteCommandType = .webview) {
        self.usabillaInstance = usabillaInstance
        weak var weakSelf: UsabillaRemoteCommand?
        super.init(commandId: UsabillaConstants.commandId,
                   description: UsabillaConstants.description,
            type: type,
            completion: { response in
                guard let payload = response.payload else {
                    return
                }
                weakSelf?.processRemoteCommand(with: payload)
            })
        weakSelf = self
    }
    func processRemoteCommand(with payload: [String: Any]) {
        guard var usabillaInstance = usabillaInstance,
        let command = payload[UsabillaConstants.commandName] as? String else {
            return
        }
        let commands = command.split(separator: UsabillaConstants.separator)
        let usabillaCommands = commands.map { command in
            return command.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
        usabillaCommands.forEach {
            let command = UsabillaConstants.Commands(rawValue: $0.lowercased())
            switch command {
                case .initialize:
                    guard let appID = payload[UsabillaConstants.Keys.appID] as? String else {
                        return
                    }
                    if let debugEnabled = payload[UsabillaConstants.Keys.debugEnabled] as? Bool {
                        return usabillaInstance.initialize(appID: appID, debug: debugEnabled)
                    }
                    usabillaInstance.initialize(appID: appID)
                case .sendEvent:
                    guard let event = payload[UsabillaConstants.Keys.event] as? String else {
                        return
                    }
                    usabillaInstance.sendEvent(event: event)
                case .displayCampaigns:
                    guard let displayCampaigns = payload[UsabillaConstants.Keys.displayCampaigns] as? Bool else {
                        return
                    }
                    usabillaInstance.displayCampaigns = displayCampaigns
                case .loadFeedbackForm:
                    guard let formID = payload[UsabillaConstants.Keys.formID] as? String else {
                        return
                    }
                    usabillaInstance.loadFeedbackForm(formID: formID)
                case .preloadFeedbackForms:
                    guard let formIDs = payload[UsabillaConstants.Keys.formIDs] as? [String] else {
                        return
                    }
                    usabillaInstance.preloadFeedbackForms(with: formIDs)
                case .removeCachedForms:
                    usabillaInstance.removeCachedForms()
                case .dismissAutomatically:
                    guard let dismissAutomatically = payload[UsabillaConstants.Keys.dismissAutomatically] as? Bool else {
                        return
                    }
                    usabillaInstance.dismissAutomatically(dismissAutomatically)
                case .setCustomVariables:
                    if let customVariables = payload[UsabillaConstants.Keys.customPrefix] as? [String: Any] {
                        usabillaInstance.setCustomVariables(customVariables)
                    } else {
                        let customVariables = payload.filter { key, value in
                            key.starts(with: UsabillaConstants.Keys.customPrefix)
                        }
                        usabillaInstance.setCustomVariables(customVariables)
                    }
                case .reset:
                    usabillaInstance.reset()
                default:
                    break
            }

        }
            
    }
    
}
