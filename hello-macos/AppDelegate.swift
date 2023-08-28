//
//  AppDelegate.swift
//  hello-macos
//
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
        if let viewController = NSApp.windows.first?.contentViewController as? ViewController {
            viewController.onApplicationStarted()
        }
    }

    func setupLDClient() {
        var contextBuilder = LDContextBuilder(key: "test@email.com")
        contextBuilder.trySetValue("firstName", .string("Bob"))
        contextBuilder.trySetValue("lastName", .string("Loblaw"))
        contextBuilder.trySetValue("groups", .array([.string("beta_testers")]))

        guard case .success(let context) = contextBuilder.build()
        else { return }

        var config = LDConfig(mobileKey: launchDarklyMobileKey, autoEnvAttributes: .enabled)
        config.flagPollingInterval = 30.0
        config.enableBackgroundUpdates = true
        config.eventFlushInterval = 30.0

        LDClient.start(config: config, context: context)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

