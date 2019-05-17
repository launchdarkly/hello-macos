//
//  AppDelegate.swift
//  hello-macos
//
//  Created by Danial Zahid on 4/11/17.
//  Copyright © 2017 LaunchDarkly. All rights reserved.
//

import Cocoa
import LaunchDarkly

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let launchDarklyMobileKey = ""

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        setupLDClient()
    }

    func setupLDClient() {
        var user = LDUser(key: "bob@example.com")
        user.firstName = "Bob"
        user.lastName = "Loblaw"
        user.custom = ["groups": ["beta_testers"]]

        var config = LDConfig(mobileKey: launchDarklyMobileKey)
        config.flagPollingInterval = 30.0
        config.enableBackgroundUpdates = true

        LDClient.shared.start(config: config, user: user)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

