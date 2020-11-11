//
//  BasicTipApp.swift
//  Shared
//
//  Created by Matt Gilboy on 11/11/20.
//  Copyright © 2020 Matt Gilboy. All rights reserved.
//

import SwiftUI

@main
struct BasicTipApp: App {
    @Environment(\.openURL) var openUrl
    @StateObject private var model = TipCalculatorModel()

    var body: some Scene {
        WindowGroup {
            AppView()
                .environmentObject(model)
        }
        .commands {
            CommandGroup(replacing: CommandGroupPlacement.help) {
                Button(action: {
                    openUrl(URL(string: "https://mattgilboy.com/basictip/")!)
                }) {
                    Text("BasicTip Website")
                }
                Button(action: {
                    openUrl(URL(string: "https://mattgilboy.com/basictip/privacy.html")!)
                }) {
                    Text("Privacy Policy")
                }
            }
        }
    }
}
