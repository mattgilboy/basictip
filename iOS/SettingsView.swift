//
//  SettingsView.swift
//  TipCalculator
//
//  Created by Matt Gilboy on 11/11/20.
//  Copyright © 2020 Matt Gilboy. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var model: TipCalculatorModel
    @Environment(\.openURL) var openUrl
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var botTipPercent: String
    @Binding var topTipPercent: String
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: HStack {
                    Text("Percentage Range")
                    if !model.validTipRange() {
                        Spacer()
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(.red)
                            .font(.title2)
                    }
                }) {
                    HStack {
                        Text("Low")
                            .frame(minWidth: 75, alignment: .leading)
                        TextField("0", text: $botTipPercent)
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("High")
                            .frame(minWidth: 75, alignment: .leading)
                        TextField("0", text: $topTipPercent)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section(footer: Text("Copyright © 2020 Matt Gilboy. All rights reserved.")) {
                    Button(action: {}) {
                        Label("Privacy Policy", systemImage: "hand.raised")
                    }
                    .onTapGesture(perform: {
                        openPrivacyPolicy()
                    })
                    Button(action: {}) {
                        Label("Application Website", systemImage: "safari")
                    }
                    .onTapGesture(perform: {
                        openApplicationWebsite()
                    })
                }
            }
            .navigationBarTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Done")
                    }
                }
            }
            .onDisappear(perform: {
                model.updateTipRange()
            })
        }
    }
    
    func openPrivacyPolicy() {
        openUrl(URL(string: "https://mattgilboy.com/basictip/privacy.html")!)
    }
    
    func openApplicationWebsite() {
        openUrl(URL(string: "https://mattgilboy.com/basictip/")!)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(botTipPercent: .constant("15.0"),
                     topTipPercent: .constant("25.0"))
    }
}
