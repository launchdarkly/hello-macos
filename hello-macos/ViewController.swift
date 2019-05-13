//
//  ViewController.swift
//  hello-macos
//
//  Created by Danial Zahid on 4/11/17.
//  Copyright © 2017 LaunchDarkly. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    let mobileKey = ""
    let flagKey = "hello-ios-boolean"

    @IBOutlet weak var valueLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLDClient()
        checkFeatureValue()
    }

    func setupLDClient() {
        var user = LDUser(key: "bob@example.com")
        user.firstName = "Bob"
        user.lastName = "Loblaw"
        user.custom = ["groups": ["beta_testers"]]

        var config = LDConfig(mobileKey: mobileKey)
        config.eventFlushInterval = 30.0
//        config.backgroundFlagPollingInterval = 60.0
//        config.streamingMode = .polling
//        config.flagPollingInterval = 30.0
        config.enableBackgroundUpdates = true

        LDClient.shared.observe(key: flagKey, owner: self) { [weak self] (changedFlag) in
            self?.featureFlagDidUpdate(changedFlag.key)
        }
        LDClient.shared.start(config: config, user: user)
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

