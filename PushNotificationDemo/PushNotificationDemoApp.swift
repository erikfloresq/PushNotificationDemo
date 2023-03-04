//
//  PushNotificationDemoApp.swift
//  PushNotificationDemo
//
//  Created by Erik Flores on 4/03/23.
//

import SwiftUI

@main
struct PushNotificationDemoApp: App {
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
