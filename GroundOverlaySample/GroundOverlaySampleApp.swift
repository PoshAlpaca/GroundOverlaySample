import GoogleMaps
import SwiftUI

@main
struct GroundOverlaySampleApp: App {
  @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

  var body: some Scene {
    WindowGroup {
      MapView()
        .edgesIgnoringSafeArea(.all)
    }
  }
}


final class AppDelegate: UIResponder, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    GMSServices.provideAPIKey(googleMapsAPIKey)
    return true
  }
}
