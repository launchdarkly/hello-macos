import Cocoa
import LaunchDarkly

class ViewController: NSViewController {

    // Set featureFlagKey to the feature flag key you want to evaluate.
    let featureFlagKey = "sample-feature"

    @IBOutlet weak var valueLabel: NSTextField!

    func onApplicationStarted() {
        if let ld = LDClient.get() {
            ld.observe(key: featureFlagKey, owner: self) { [weak self] changedFlag in
                guard let me = self else { return }
                guard case .bool(let booleanValue) = changedFlag.newValue else { return }

                me.updateUi(flagKey: changedFlag.key, result: booleanValue)
            }
            let result = ld.boolVariation(forKey: featureFlagKey, defaultValue: false)
            updateUi(flagKey: featureFlagKey, result: result)
        }
    }

    func updateUi(flagKey: String, result: Bool) {
        self.valueLabel.stringValue = "The \(flagKey) feature flag evaluates to \(result)"

        let toggleOn = NSColor(red: 0, green: 0.52, blue: 0.29, alpha: 1).cgColor
        let toggleOff = NSColor(red: 0.22, green: 0.22, blue: 0.25, alpha: 1).cgColor

        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = result ? toggleOn : toggleOff
    }
}
