import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    var keys: NSDictionary?
    if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
      keys = NSDictionary(contentsOfFile: path)
    }
    if let dict = keys {
      let mapsApiKey = dict["MapsApiKey"] as? String
      GMSServices.provideAPIKey(mapsApiKey)
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
