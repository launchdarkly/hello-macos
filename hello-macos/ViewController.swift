//
//  ViewController.swift
//  hello-macos
//
//  Created by Danial Zahid on 4/11/17.
//  Copyright © 2017 LaunchDarkly. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, ClientDelegate {
    let mobileKey = ""
    let flagKey = "test-flag"

    @IBOutlet weak var valueLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LDClient.sharedInstance().delegate = self
        setupLDClient()
        checkFeatureValue()

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func setupLDClient() {
        let builder = LDUserBuilder()
        builder.key = "bob@example.com"
        builder.firstName = "Bob"
        builder.lastName = "Loblaw"
        builder.customDictionary = ["groups": ["beta_testers"]]
        
        let config = LDConfig(mobileKey: mobileKey)
        
        LDClient.sharedInstance().start(config, with: builder)
        LDClient.sharedInstance().delegate = self
    }
    
    func checkFeatureValue() {
        let showFeature = LDClient.sharedInstance().boolVariation(flagKey, fallback: false)
        updateLabel(value: "\(showFeature)")
    }
    
    func updateLabel(value: String){
        valueLabel.stringValue = "Flag value: \(value)"
    }
    
    //MARK: - ClientDelegate Methods
    
    func featureFlagDidUpdate(_ key: String) {
        if key == flagKey {
            checkFeatureValue()
        }
    }
    
}

