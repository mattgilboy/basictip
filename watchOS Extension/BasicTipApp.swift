//
//  BasicTipApp.swift
//  watchOS Extension
//
//  Created by Matt Gilboy on 11/11/20.
//  Copyright © 2020 Matt Gilboy. All rights reserved.
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
