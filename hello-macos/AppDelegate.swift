import Cocoa
import LaunchDarkly

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // Set sdkKey to your LaunchDarkly mobile key.
    let sdkKey = ""

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupLDClient()
        if let viewController = NSApp.windows.first?.contentViewController as? ViewController {
            viewController.onApplicationStarted()
        }
    }

    func setupLDClient() {
        // Set up the evaluation context. This context should appear on your 
        // LaunchDarkly contexts dashboard soon after you run the demo.
        var contextBuilder = LDContextBuilder(key: "example-user-key")
        contextBuilder.kind("user")
        contextBuilder.name("Sandy")

        guard case .success(let context) = contextBuilder.build()
        else { return }

        var config = LDConfig(mobileKey: sdkKey, autoEnvAttributes: .enabled)

        LDClient.start(config: config, context: context)
    }
}
