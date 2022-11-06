//
//  SandboxApp.swift
//  Sandbox
//
//  Created by hiroya-hinomori on 2022/10/02.
//

import SwiftUI
import App
import Firebase

@main
struct SandboxApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            AppView(injection: .init(queue: .main))
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
  ) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
