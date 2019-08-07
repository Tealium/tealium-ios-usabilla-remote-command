//
//  ViewController.swift
//  TealiumUsabillaExample
//
//  Created by Jonathan Wong on 8/7/19.
//  Copyright © 2019 Jonathan Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        TealiumHelper.track(title: "ViewController", data: nil)
    }


}

