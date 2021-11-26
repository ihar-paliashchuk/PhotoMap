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
    GMSServices.provideAPIKey("AIzaSyCuq9k5poTbDVfJ959W5vkiGLvZ5juLml4") //todo move api key somewhere
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
