//
//  UsabillaCommandRunner.swift
//  RemoteCommandModules
//
//  Created by Jonathan Wong on 4/2/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import Foundation
import Usabilla
import TealiumSwift

protocol UsabillaCommandRunnable {

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


class UsabillaCommandRunner: UsabillaCommandRunnable {
    
    weak var tealium: Tealium?
    
    init() {
    }
    
    init(tealium: Tealium) {
        self.tealium = tealium
        Usabilla.delegate = self
    }
    
    var debugEnabled: Bool {
        get {
            return Usabilla.debugEnabled
        }
        set(newValue) {
            Usabilla.debugEnabled = newValue
        }
    }
    
    var displayCampaigns: Bool {
        get {
            return Usabilla.canDisplayCampaigns
        }
        set(newValue) {
            Usabilla.canDisplayCampaigns = newValue
        }
    }
    
    func initialize(appID: String?) {
        Usabilla.initialize(appID: appID)
    }
    
    func initialize(appID: String?, completion: (() -> Void)?) {
        Usabilla.initialize(appID: appID, completion: completion)
    }
    
    func sendEvent(event: String) {
        Usabilla.sendEvent(event: event)
    }
    
    func resetCampaignData(completion: (() -> Void)?) {
        Usabilla.resetCampaignData(completion: completion)
    }
    
    func loadFeedbackForm(formID: String) {
        Usabilla.loadFeedbackForm(formID)
    }
    
    func preloadFeedbackForms(with formIDs: [String]) {
        Usabilla.preloadFeedbackForms(withFormIDs: formIDs)
    }
    
    func removeCachedForms() {
        Usabilla.removeCachedForms()
    }
    
    func dismissAutomatically(_ automatic: Bool) {
        Usabilla.dismissAutomatically = automatic
    }
    
    func setCustomVariables(_ customVariables: [String: Any]) {
        Usabilla.customVariables = customVariables
    }
    
    func reset() {
        Usabilla.resetCampaignData(completion: nil)
    }
}

extension UsabillaCommandRunner: UsabillaDelegate {
    
    func formDidLoad(form: UINavigationController) {
        tealium?.track(title: "usabilla_form_did_load")
    }
    
    func formDidFailLoading(error: UBError) {
        tealium?.track(title: "usabilla_form_load_error",
                       data: ["error": error.description],
                       completion: nil)
    }
    
    func formDidClose(formID: String, withFeedbackResults results: [FeedbackResult], isRedirectToAppStoreEnabled: Bool) {
        let validResults = results.filter { feedbackResult in
            feedbackResult.abandonedPageIndex != nil && feedbackResult.rating != nil
        }
        tealium?.track(title: "usabilla_form_did_close",
                       data: ["usabilla_feedback_results": validResults],
                       completion: nil)
    }
    
    func campaignDidClose(withFeedbackResult result: FeedbackResult, isRedirectToAppStoreEnabled: Bool) {
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


