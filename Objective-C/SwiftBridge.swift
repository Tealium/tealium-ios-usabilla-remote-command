//
//  SwiftBridge.swift
//  TealiumRemoteCommandObjcApp
//
//  Created by Christina Sund on 8/16/19.
//  Copyright © 2019 Jonathan Wong. All rights reserved.
//

import UIKit
import Usabilla

extension ViewController: UsabillaDelegate {
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Usabilla.delegate = self
    }
    
    public func formDidLoad(form: UINavigationController) {
        form.modalPresentationStyle = .fullScreen
        present(form, animated: true, completion: nil)
    }
    
    public func formDidFailLoading(error: UBError) {
        print("Form failed to load: \(error)")
    }
    
}
