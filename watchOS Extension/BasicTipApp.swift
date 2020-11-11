//
//  BasicTipApp.swift
//  watchOS Extension
//
//  Created by Matt Gilboy on 11/11/20.
//

import SwiftUI

@main
struct BasicTipApp: App {
    @StateObject private var model = TipCalculatorModel()

    @SceneBuilder var body: some Scene {

        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(model)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
