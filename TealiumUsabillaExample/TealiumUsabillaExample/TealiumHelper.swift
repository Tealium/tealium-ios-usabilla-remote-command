//
//  TealiumHelper.swift
//  RemoteCommandModules
//
//  Created by Christina Sund on 6/18/19.
//  Copyright © 2019 Christina. All rights reserved.
//

import Foundation
import TealiumSwift

enum TealiumConfiguration {
    static let account = "tealiummobile"
    static let profile = "usabilla-tag"
    static let environment = "dev"
}

class TealiumHelper {

    static let shared = TealiumHelper()

    let config = TealiumConfig(account: TealiumConfiguration.account,
                               profile: TealiumConfiguration.profile,
                               environment: TealiumConfiguration.environment)

    var tealium: Tealium?

    private init() {
        config.setLogLevel(logLevel: .verbose)
        let list = TealiumModulesList(isWhitelist: false,
                                      moduleNames: ["autotracking", "collect", "consentmanager"])
        config.setModulesList(list)
        tealium = Tealium(config: config,
                          enableCompletion: { [weak self] _ in
                              guard let self = self else { return }
                              guard let remoteCommands = self.tealium?.remoteCommands() else {
                                  return
                              }
                              // MARK: Usabilla
                              let usablillaCommand = UsabillaCommand()
                              let usabillaRemoteCommands = usablillaCommand.remoteCommand()
                              remoteCommands.add(usabillaRemoteCommands)
                          })

    }


    public func start() {
        _ = TealiumHelper.shared
    }

    class func trackView(title: String, data: [String: Any]?) {
        TealiumHelper.shared.tealium?.track(title: title, data: data, completion: nil)
    }

    class func trackScreen<T: UIViewController>(_ view: T, name: String) {
        TealiumHelper.trackView(title: "screen_view", data: ["screen_name": name, "screen_class": "\(view.classForCoder)"])
    }

    class func trackEvent(title: String, data: [String: Any]?) {
        TealiumHelper.shared.tealium?.track(title: title, data: data, completion: nil)
    }

}
