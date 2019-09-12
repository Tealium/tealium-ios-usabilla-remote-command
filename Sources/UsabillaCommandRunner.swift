//
//  UsabillaCommandRunner.swift
//  RemoteCommandModules
//
//  Created by Jonathan Wong on 4/2/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import Foundation
import Usabilla
#if COCOAPODS
import TealiumSwift
#else
import TealiumCore
import TealiumDelegate
import TealiumTagManagement
import TealiumRemoteCommands
#endif

public protocol UsabillaCommandRunnable {

    
    var debugEnabled: Bool { get set }
    
    var displayCampaigns: Bool { get set }
    
    // MARK: Initialization
    func initialize(appID: String?)
    
    func initialize(appID: String?, completion: (() -> Void)?)
    
    // MARK: Campaigns
    func sendEvent(event: String)
    
    func resetCampaignData(completion: (() -> Void)?)
    
    // MARK: Passive Feedback
    func loadFeedbackForm(formID: String)
    
    func preloadFeedbackForms(with formIDs: [String])
    
    func removeCachedForms()
    
    func dismissAutomatically(_ automatic: Bool)
    
    func setCustomVariables(_ customVariables: [String: Any])
    
    func reset()
}


public class UsabillaCommandRunner: UsabillaCommandRunnable {
    
    weak var tealium: Tealium?
    
    public init() {
    }
    
    public init(tealium: Tealium) {
        self.tealium = tealium
        Usabilla.delegate = self
    }
    
    public var debugEnabled: Bool {
        get {
            return Usabilla.debugEnabled
        }
        set(newValue) {
            Usabilla.debugEnabled = newValue
        }
    }
    
    public var displayCampaigns: Bool {
        get {
            return Usabilla.canDisplayCampaigns
        }
        set(newValue) {
            Usabilla.canDisplayCampaigns = newValue
        }
    }
    
    public func initialize(appID: String?) {
        Usabilla.initialize(appID: appID)
    }
    
    public func initialize(appID: String?, completion: (() -> Void)?) {
        Usabilla.initialize(appID: appID, completion: completion)
    }
    
    public func sendEvent(event: String) {
        Usabilla.sendEvent(event: event)
    }
    
    public func resetCampaignData(completion: (() -> Void)?) {
        Usabilla.resetCampaignData(completion: completion)
    }
    
    public func loadFeedbackForm(formID: String) {
        Usabilla.loadFeedbackForm(formID)
    }
    
    public func preloadFeedbackForms(with formIDs: [String]) {
        Usabilla.preloadFeedbackForms(withFormIDs: formIDs)
    }
    
    public func removeCachedForms() {
        Usabilla.removeCachedForms()
    }
    
    public func dismissAutomatically(_ automatic: Bool) {
        Usabilla.dismissAutomatically = automatic
    }
    
    public func setCustomVariables(_ customVariables: [String: Any]) {
        Usabilla.customVariables = customVariables
    }
    
    public func reset() {
        Usabilla.resetCampaignData(completion: nil)
    }
}

extension UsabillaCommandRunner: UsabillaDelegate {
    
    public func formDidLoad(form: UINavigationController) {
        tealium?.track(title: "usabilla_form_did_load")
    }
    
    public func formDidFailLoading(error: UBError) {
        tealium?.track(title: "usabilla_form_load_error",
                       data: ["error": error.description],
                       completion: nil)
    }
    
    public func formDidClose(formID: String, withFeedbackResults results: [FeedbackResult], isRedirectToAppStoreEnabled: Bool) {
        let validResults = results.filter { feedbackResult in
            feedbackResult.abandonedPageIndex != nil && feedbackResult.rating != nil
        }
        tealium?.track(title: "usabilla_form_did_close",
                       data: ["usabilla_feedback_results": validResults],
                       completion: nil)
    }
    
    public func campaignDidClose(withFeedbackResult result: FeedbackResult, isRedirectToAppStoreEnabled: Bool) {
        guard let rating = result.rating, let abandonedPageIndex = result.abandonedPageIndex else {
            tealium?.track(title: "usabilla_form_closed")
            return
        }
        
        tealium?.track(title: "usabilla_form_closed",
                       data: [
                        "usabilla_rating": rating,
                        "usabilla_abandoned_page_index": abandonedPageIndex,
                        "usabilla_sent": result.sent
            ], completion: nil)
    }
}


