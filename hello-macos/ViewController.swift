//
//  ViewController.swift
//  hello-macos
//
//  Copyright © 2017 LaunchDarkly. All rights reserved.
//

import Cocoa
import LaunchDarkly

class ViewController: NSViewController {

    let flagKey = "test-flag"

    @IBOutlet weak var valueLabel: NSTextField!

    func onApplicationStarted() {
        registerLDClientObservers()
        checkFeatureValue()
    }

    func registerLDClientObservers() {
        LDClient.get()!.observe(key: flagKey, owner: self) { [weak self] changedFlag in
            self?.featureFlagDidUpdate(changedFlag.key)
        }
    }
    
    func checkFeatureValue() {
        let showFeature = LDClient.get()!.variation(forKey: flagKey, defaultValue: false)
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

