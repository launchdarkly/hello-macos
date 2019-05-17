//
//  ViewController.swift
//  hello-macos
//
//  Created by Danial Zahid on 4/11/17.
//  Copyright © 2017 LaunchDarkly. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let flagKey = "test-flag"

    @IBOutlet weak var valueLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerLDClientObservers()
        checkFeatureValue()
    }

    func registerLDClientObservers() {
        LDClient.shared.observe(key: flagKey, owner: self) { [weak self] (changedFlag) in
            self?.featureFlagDidUpdate(changedFlag.key)
        }
    }
    
    func checkFeatureValue() {
        let showFeature = LDClient.shared.variation(forKey: flagKey, fallback: false)
        updateLabel(value: "\(showFeature)")
    }
    
    func updateLabel(value: String){
        valueLabel.stringValue = "Flag value: \(value)"
    }
    
    //MARK: - ClientDelegate Methods
    
    func featureFlagDidUpdate(_ key: String!) {
        if key == flagKey {
            checkFeatureValue()
        }
    }
    
}

