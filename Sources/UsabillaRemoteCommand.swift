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
import TealiumTagManagement
import TealiumRemoteCommands
#endif

public class UsabillaRemoteCommand: RemoteCommand {
    
    var usabillaTracker: UsabillaTrackable?

    public init(usabillaTracker: UsabillaTrackable = UsabillaTracker(),
                type: RemoteCommandType = .webview) {
        self.usabillaTracker = usabillaTracker
        weak var selfWorkaround: UsabillaRemoteCommand?
        super.init(commandId: UsabillaConstants.commandId,
                   description: UsabillaConstants.description,
            type: type,
            completion: { response in
                guard let payload = response.payload else {
                    return
                }
                selfWorkaround?.processRemoteCommand(with: payload)
            })
        selfWorkaround = self
    }
    func processRemoteCommand(with payload: [String: Any]) {
        guard var usabillaTracker = usabillaTracker,
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
                        return usabillaTracker.initialize(appID: appID, debug: debugEnabled)
                    }
                    usabillaTracker.initialize(appID: appID)
                case .sendEvent:
                    guard let event = payload[UsabillaConstants.Keys.event] as? String else {
                        return
                    }
                    usabillaTracker.sendEvent(event: event)
                case .displayCampaigns:
                    guard let displayCampaigns = payload[UsabillaConstants.Keys.displayCampaigns] as? Bool else {
                        return
                    }
                    usabillaTracker.displayCampaigns = displayCampaigns
                case .loadFeedbackForm:
                    guard let formID = payload[UsabillaConstants.Keys.formID] as? String else {
                        return
                    }
                    usabillaTracker.loadFeedbackForm(formID: formID)
                case .preloadFeedbackForms:
                    guard let formIDs = payload[UsabillaConstants.Keys.formIDs] as? [String] else {
                        return
                    }
                    usabillaTracker.preloadFeedbackForms(with: formIDs)
                case .removeCachedForms:
                    usabillaTracker.removeCachedForms()
                case .dismissAutomatically:
                    guard let dismissAutomatically = payload[UsabillaConstants.Keys.dismissAutomatically] as? Bool else {
                        return
                    }
                    usabillaTracker.dismissAutomatically(dismissAutomatically)
                case .setCustomVariables:
                    if let customVariables = payload[UsabillaConstants.Keys.customPrefix] as? [String: Any] {
                        usabillaTracker.setCustomVariables(customVariables)
                    } else {
                        let customVariables = payload.filter { key, value in
                            key.starts(with: UsabillaConstants.Keys.customPrefix)
                        }
                        usabillaTracker.setCustomVariables(customVariables)
                    }
                case .reset:
                    usabillaTracker.reset()
                default:
                    break
            }

        }
            
    }
    
}
