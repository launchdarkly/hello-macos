//
//  AppDelegate.swift
//  hello-macos
//
//  Created by Danial Zahid on 4/11/17.
//  Copyright © 2017 LaunchDarkly. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let launchDarklyMobileKey = ""

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        setupLDClient()
    }

    func setupLDClient() {
        let builder = LDUserBuilder()
        builder.key = "bob@example.com"
        builder.firstName = "Bob"
        builder.lastName = "Loblaw"
        builder.customDictionary = ["groups": ["beta_testers"]]

        let config = LDConfig(mobileKey: launchDarklyMobileKey)

        LDClient.sharedInstance().start(config, with: builder)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

