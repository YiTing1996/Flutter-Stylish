import UIKit
import Flutter
import GoogleMaps
import TPDirect

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let TPD_METHOD_CHANNEL = "stylish.com/tappay"
        let TPD_APP_ID: Int32 = 12348
        let TPD_APP_KEY = "app_pa1pQcKoY22IlnSXq5m5WP5jFKzoRG58VEXpT7wU62ud7mMbDOGzCYIlzzLF"
        
        // Register channel
        let controller: FlutterViewController = window.rootViewController as! FlutterViewController
        let tappayChannel = FlutterMethodChannel(
            name: TPD_METHOD_CHANNEL,
            binaryMessenger: controller.binaryMessenger
        )
        
        // Setup tappay
        TPDSetup.setWithAppId(TPD_APP_ID, withAppKey: TPD_APP_KEY, with: TPDServerType.sandBox)
        
        // Channel handler
        tappayChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            guard let args = call.arguments as? [String: Any] else {
                result("args cast error")
                return
            }
            switch call.method {
            case "getPrime":
                self.setupTappay(args: args) { tapRsp in
                    result(tapRsp)
                }
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    private func setupTappay(args: [String: Any], completion: @escaping (String) -> Void) {
        
        let cardNumber = (args["cardNumber"] as? String ?? "")
        let dueMonth = (args["dueMonth"] as? String ?? "")
        let dueYear = (args["dueYear"] as? String ?? "")
        let ccv = (args["ccv"] as? String ?? "")
        
        let card = TPDCard.setWithCardNumber(cardNumber, withDueMonth: dueMonth, withDueYear: dueYear, withCCV: ccv)
        card.onSuccessCallback { (tpPrime, cardInfo, cardIdentifier, merchantReferenceInfo) in
            if let tpPrime = tpPrime {
                completion("{\"status\":\"\", \"message\":\"\", \"prime\":\"\(tpPrime)\"}")
            }
        }.onFailureCallback { (status, message) in
            completion("{\"status\":\"\(status)\", \"message\":\"\(message)\", \"prime\":\"\"}")
        }.createToken(withGeoLocation: "UNKNOWN")
    }
}
