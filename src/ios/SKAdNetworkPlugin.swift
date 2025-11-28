import Foundation
import StoreKit

@objc(SKAdNetworkPlugin) class SKAdNetworkPlugin: CDVPlugin {

    /// Update the SKAdNetwork conversion value
    /// - Parameter command: Cordova command with conversionValue as first argument
    @objc(updateConversionValue:)
    func updateConversionValue(command: CDVInvokedUrlCommand) {
        let conversionValue = command.arguments[0] as? Int ?? 63

        DispatchQueue.main.async {
            if #available(iOS 15.4, *) {
                SKAdNetwork.updatePostbackConversionValue(conversionValue) { error in
                    if let error = error {
                        print("SKAdNetwork: Error updating postback conversion value: \(error.localizedDescription)")
                        let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
                        self.commandDelegate.send(result, callbackId: command.callbackId)
                    } else {
                        print("SKAdNetwork: Successfully updated postback conversion value to \(conversionValue)")
                        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Conversion value updated to \(conversionValue)")
                        self.commandDelegate.send(result, callbackId: command.callbackId)
                    }
                }
            } else if #available(iOS 14.0, *) {
                SKAdNetwork.updateConversionValue(conversionValue)
                print("SKAdNetwork: Updated conversion value to \(conversionValue) (iOS < 15.4)")
                let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Conversion value updated to \(conversionValue)")
                self.commandDelegate.send(result, callbackId: command.callbackId)
            } else {
                print("SKAdNetwork: Not available on this iOS version")
                let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "SKAdNetwork not available on iOS < 14.0")
                self.commandDelegate.send(result, callbackId: command.callbackId)
            }
        }
    }

    /// Update with coarse conversion value (iOS 16.1+)
    /// - Parameter command: Cordova command with conversionValue, coarseValue, and lockWindow as arguments
    @objc(updatePostbackConversionValue:)
    func updatePostbackConversionValue(command: CDVInvokedUrlCommand) {
        let conversionValue = command.arguments[0] as? Int ?? 63
        let coarseValue = command.arguments[1] as? String ?? "high"
        let lockWindow = command.arguments[2] as? Bool ?? true

        DispatchQueue.main.async {
            if #available(iOS 16.1, *) {
                let coarse: SKAdNetwork.CoarseConversionValue
                switch coarseValue.lowercased() {
                case "low":
                    coarse = .low
                case "medium":
                    coarse = .medium
                default:
                    coarse = .high
                }

                SKAdNetwork.updatePostbackConversionValue(conversionValue, coarseValue: coarse, lockWindow: lockWindow) { error in
                    if let error = error {
                        print("SKAdNetwork: Error updating postback with coarse value: \(error.localizedDescription)")
                        let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
                        self.commandDelegate.send(result, callbackId: command.callbackId)
                    } else {
                        print("SKAdNetwork: Successfully updated postback conversion value to \(conversionValue), coarse: \(coarseValue), lockWindow: \(lockWindow)")
                        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Conversion value updated to \(conversionValue) with coarse value \(coarseValue)")
                        self.commandDelegate.send(result, callbackId: command.callbackId)
                    }
                }
            } else if #available(iOS 15.4, *) {
                // Fallback to simple postback update
                SKAdNetwork.updatePostbackConversionValue(conversionValue) { error in
                    if let error = error {
                        let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
                        self.commandDelegate.send(result, callbackId: command.callbackId)
                    } else {
                        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Conversion value updated to \(conversionValue) (coarse value not supported on iOS < 16.1)")
                        self.commandDelegate.send(result, callbackId: command.callbackId)
                    }
                }
            } else if #available(iOS 14.0, *) {
                SKAdNetwork.updateConversionValue(conversionValue)
                let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Conversion value updated to \(conversionValue)")
                self.commandDelegate.send(result, callbackId: command.callbackId)
            } else {
                let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "SKAdNetwork not available on iOS < 14.0")
                self.commandDelegate.send(result, callbackId: command.callbackId)
            }
        }
    }

    /// Lock the conversion value to 63 (maximum value indicating high-value user)
    /// - Parameter command: Cordova command
    @objc(lockConversionValue:)
    func lockConversionValue(command: CDVInvokedUrlCommand) {
        DispatchQueue.main.async {
            if #available(iOS 15.4, *) {
                SKAdNetwork.updatePostbackConversionValue(63) { error in
                    if let error = error {
                        print("SKAdNetwork: Error locking SKAN value: \(error.localizedDescription)")
                        let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error.localizedDescription)
                        self.commandDelegate.send(result, callbackId: command.callbackId)
                    } else {
                        print("SKAdNetwork: Successfully locked conversion value to 63")
                        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Conversion value locked to 63")
                        self.commandDelegate.send(result, callbackId: command.callbackId)
                    }
                }
            } else if #available(iOS 14.0, *) {
                SKAdNetwork.updateConversionValue(63)
                print("SKAdNetwork: Locked conversion value to 63 (iOS < 15.4)")
                let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "Conversion value locked to 63")
                self.commandDelegate.send(result, callbackId: command.callbackId)
            } else {
                print("SKAdNetwork: Not available on this iOS version")
                let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "SKAdNetwork not available on iOS < 14.0")
                self.commandDelegate.send(result, callbackId: command.callbackId)
            }
        }
    }

    /// Register app for SKAdNetwork attribution
    /// - Parameter command: Cordova command
    @objc(registerAppForAttribution:)
    func registerAppForAttribution(command: CDVInvokedUrlCommand) {
        DispatchQueue.main.async {
            if #available(iOS 14.0, *) {
                SKAdNetwork.registerAppForAdNetworkAttribution()
                print("SKAdNetwork: Registered app for attribution")
                let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: "App registered for attribution")
                self.commandDelegate.send(result, callbackId: command.callbackId)
            } else {
                let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: "SKAdNetwork not available on iOS < 14.0")
                self.commandDelegate.send(result, callbackId: command.callbackId)
            }
        }
    }
}
