//
//  ViewController.swift
//  TealiumUsabillaExample
//
//  Created by Christina Sund on 8/14/19.
//  Copyright © 2019 Tealium. All rights reserved.
//

import UIKit
import Usabilla

// Image credit: https://www.flaticon.com/authors/eucalyp 🙏
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Usabilla.delegate = self
    }
    
    @IBAction func displayCampaigns(_ sender: UISwitch) {
        let displayCampaigns = sender.isOn ? true : false
        TealiumHelper.trackEvent(title: "display_campaigns", data: ["display_campaigns": displayCampaigns])
    }
    
    @IBAction func dismissForms(_ sender: UISwitch) {
        let dismissAutomatically = sender.isOn ? true : false
        TealiumHelper.trackEvent(title: "dismiss", data: ["dismiss_automatically": dismissAutomatically])
    }
    
    @IBAction func sendEvent(_ sender: UIButton) {
        TealiumHelper.trackEvent(title: "button_click", data: ["event_name": "send_event_clicked"])
    }
    
    @IBAction func loadFeedbackFrom(_ sender: UIButton) {
        TealiumHelper.trackEvent(title: "load_form", data: nil)
    }
    
    @IBAction func setCustomVariable(_ sender: UIButton) {
        let ac = UIAlertController(title: "Set First Name", message: "Enter first name to set for custom variable", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Set", style: .default) { _ in
            if let text = ac.textFields?[0].text {
                TealiumHelper.trackEvent(title: "set_variables", data: ["customer_first_name": text])
            }
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    @IBAction func reset(_ sender: UIButton) {
        TealiumHelper.trackEvent(title: "reset", data: nil)
    }
     
}

extension ViewController: UsabillaDelegate {
    func formDidLoad(form: UINavigationController) {
        form.modalPresentationStyle = .fullScreen
        present(form, animated: true, completion: nil)
    }
    
    func formDidFailLoading(error: UBError) {
        print("Form failed to load")
    }
}
