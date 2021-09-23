//
//  TestAppApp.swift
//  TestApp
//
//  Created by Maxim Potapov on 23.09.2021.
//

import SwiftUI

@available(iOS 14.0, *)
@main
struct TestAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
