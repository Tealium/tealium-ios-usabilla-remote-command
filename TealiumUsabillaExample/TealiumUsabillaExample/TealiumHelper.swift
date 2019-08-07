//
//  TealiumHelper.swift
//  TealiumUsabillaExample
//
//  Created by Jonathan Wong on 8/7/19.
//  Copyright © 2019 Jonathan Wong. All rights reserved.
//

import Foundation
import TealiumCore
import TealiumCollect
import TealiumRemoteCommands
import TealiumLogger
//import TealiumUsabilla

class TealiumHelper {
    
    static let shared = TealiumHelper()
    let config = TealiumConfig(account: "tealiummobile",
                               profile: "usabilla-tag",
                               environment: "qa")
    
    var tealium: Tealium?
    static var universalData = [String: Any]()
    
    private init() {
        config.setLogLevel(logLevel: .verbose)
        
        let modulesList = TealiumModulesList(isWhitelist: false,
                                             moduleNames: ["autotracking",
                                                           "collect",
                                                           "consentmanager"])
        config.setModulesList(modulesList)
        tealium = Tealium(config: config) { responses in
            guard let remoteCommands = self.tealium?.remoteCommands() else {
                return
            }
//            let usabillaCommandRunner = UsabillaCommandRunner()
//            let usabillaCommand = UsabillaCommand(usabillaCommandRunner: usabillaCommandRunner)
//            let usabillaRemoteCommand = usabillaCommand.remoteCommand()
//            remoteCommands.add(usabillaRemoteCommand)
        }
    }
    
    class func start() {
        _ = TealiumHelper.shared
    }
    
    class func track(title: String, data: [String: Any]?) {
        if let data = data {
            universalData = universalData.merging(data) { _, new in new }
        }
        TealiumHelper.shared.tealium?.track(title: title, data: universalData, completion: nil)
    }
}
