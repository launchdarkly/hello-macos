//
//  ViewController.swift
//  hello-macos
//
//  Created by Danial Zahid on 4/11/17.
//  Copyright © 2017 LaunchDarkly. All rights reserved.
//

import Cocoa

let MOBILE_KEY = ""
let FLAG_KEY = ""

class ViewController: NSViewController, ClientDelegate {

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
        var builder = LDUserBuilder()
        builder = builder.withKey("bob@example.com")
        builder = builder.withFirstName("Bob")
        builder = builder.withLastName("Loblaw")
        
        let groups = ["beta_testers"]
        builder.withCustomArray("groups", value: groups)
        
        let config = LDConfigBuilder()
        config.withMobileKey(MOBILE_KEY)
        
        LDClient.sharedInstance().start(config, userBuilder: builder)
    }
    
    func checkFeatureValue() {
        let showFeature = LDClient.sharedInstance().boolVariation(FLAG_KEY, fallback: false)
        updateLabel(value: "\(showFeature)")
    }
    
    func updateLabel(value: String){
        valueLabel.stringValue = "Flag value: \(value)"
    }
    
    //MARK: - ClientDelegate Methods
    
    func featureFlagDidUpdate(_ key: String!) {
        if key == FLAG_KEY {
            checkFeatureValue()
        }
    }
    
}

