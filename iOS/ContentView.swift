//
//  ContentView.swift
//  Shared
//
//  Created by Matt Gilboy on 9/2/20.
//

import SwiftUI
import SafariServices

let colorDark = Color(red: 0.075, green: 0.075, blue: 0.075)
let colorLight = Color(red: 0.975, green: 0.975, blue: 0.975)

struct ContentView: View {
    @EnvironmentObject private var model: TipCalculatorModel
    @StateObject private var keyboardManager = KeyboardManager()
    @State private var showingSettings = false
    @State private var managedKeyboardIsVisible = false
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            HStack {
                Text("BasicTip")
                    .font(.largeTitle)
                    .bold()
                Spacer()
                
                if (managedKeyboardIsVisible) {
                    Button(action: {
                        hideKeyboard()
                    }) {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .font(.title)
                            .padding(.trailing)
                    }
                }
                
                Button(action: {
                    showingSettings.toggle()
                }) {
                    Image(systemName: "gearshape")
                        .font(.title)
                }
            }
            .padding(.horizontal)
            
            // Bill
            TopInputView(text: $model.bill,
                         validText: model.validBill(),
                         symbol: "dollarsign.square.fill",
                         symbolColor: Color.red,
                         label: "Bill",
                         placeholder: "0.00",
                         keyboard: .decimalPad)
            
            // Split
            TopInputView(text: $model.split,
                         validText: model.validSplit(),
                         symbol: "divide.square.fill",
                         symbolColor: Color.green,
                         label: "Split",
                         placeholder: "1",
                         keyboard: .numberPad)
            
            // Tip Percent, Round Up
            MidInputView(tipPercent: $model.tipPercent,
                         roundUp: $model.roundUp,
                         botTipValue: model.botTipValue,
                         topTipValue: model.topTipValue)
            
            Spacer()
            
            // Output
            HStack {
                BotOutputView(label: "Tip",
                              value: model.tip,
                              format: "$%0.2f")
                BotOutputView(label: "Percent",
                              value: model.tipPercent,
                              format: "%0.1f%%")
            }
            
            HStack {
                BotOutputView(label: "Per Person",
                              value: model.perPerson,
                              format: "$%0.2f")
                BotOutputView(label: "Total",
                              value: model.total,
                              format: "$%0.2f")
            }
        }
        .padding()
        .onAppear() {
            keyboardManager.addObserver()
        }
        .onDisappear() {
            keyboardManager.removeObserver()
        }
        .onTapGesture {
            hideKeyboard()
        }
        .onReceive(timer) { _ in
            withAnimation {
                managedKeyboardIsVisible = keyboardManager.managedKeyboardIsVisible
            }
        }
        .lineLimit(1)
        .minimumScaleFactor(0.1)
        .sheet(isPresented: $showingSettings) {
            SettingsView(botTipPercent: $model.botTipString,
                         topTipPercent: $model.topTipString)
                .environmentObject(model)
        }
    }
}

/// Configurable view that displays a system Image, Text, and TextField.
struct TopInputView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    var validText: Bool
    var symbol: String
    var symbolColor: Color
    var label: String
    var placeholder: String
    var keyboard: UIKeyboardType
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: symbol)
                .foregroundColor(symbolColor)
                .font(.title)
            Text(label)
            Spacer()
            TextField(placeholder, text: $text)
                .keyboardType(keyboard)
                .multilineTextAlignment(.trailing)
                .font(.title)
                .foregroundColor(!validText ?
                                    Color.red :
                                    colorScheme == .dark ?
                                        Color.white : Color.black
                )
        }
        .font(.title2)
        .padding()
        .background(BackgroundRectangle())
    }
}

/// View that manages the tipPercent and roundUp inputs.
struct MidInputView: View {
    @Binding var tipPercent: Double
    @Binding var roundUp: Bool
    var botTipValue: Int
    var topTipValue: Int
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .foregroundColor(Color.yellow)
                    .font(.title)
                Text("Tip Percent")
                Spacer()
                Text(String(format:"%0.1f%%", tipPercent))
            }

            Slider(value: $tipPercent,
                   in: Double(botTipValue)...Double(topTipValue),
                   step: 0.5)
                .padding(.bottom)
                .onTapGesture {
                    // Override keyboard hiding
                }
            
            Toggle(isOn: $roundUp) {
                Image(systemName: "arrow.up.square.fill")
                    .foregroundColor(Color.purple)
                    .font(.title)
                Text("Round Up")
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            .onTapGesture {
                // Override keyboard hiding
            }
        }
        .font(.title2)
        .padding()
        .background(BackgroundRectangle())
    }
}

/// Output view used for the calculated results.
struct BotOutputView: View {
    @Environment(\.colorScheme) var colorScheme

    var label: String
    var value: Double
    var format: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15.0)
                .fill(colorScheme == .dark ? colorDark : colorLight)
                .frame(height: 80)

            VStack {
                Text(label)
                    .font(.title3)
                Text(String(format: format, value))
                    .font(.title)
                    .bold()
            }
        }
    }
}

struct BackgroundRectangle: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        RoundedRectangle(cornerRadius: 15.0)
            .fill(colorScheme == .dark ? colorDark : colorLight)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
