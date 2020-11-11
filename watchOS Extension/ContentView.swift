//
//  ContentView.swift
//  watchOS Extension
//
//  Created by Matt Gilboy on 11/11/20.
//  Copyright © 2020 Matt Gilboy. All rights reserved.
//

import SwiftUI

let imageSpacerWidth: CGFloat = 8.0

struct ContentView: View {
    @EnvironmentObject private var model: TipCalculatorModel
    @State var showingBillInputView = false
    
    var body: some View {
        ScrollView {
            // Bill
            HStack(alignment: .center) {
                Image(systemName: "dollarsign.square.fill")
                    .foregroundColor(Color.red)
                    .font(.title2)
                Spacer()
                    .frame(width: imageSpacerWidth)
                Text("Bill")
                    .font(.title3)
                Spacer()
            }
            HStack() {
                if (model.bill == "") {
                    Button(action: {
                        showingBillInputView.toggle()
                    }) {
                        Text("0.00")
                    }
                } else {
                    Button(action: {
                        showingBillInputView.toggle()
                    }) {
                        Text(model.bill)
                    }
                }
            }
            .font(.title2)
            .padding(.bottom)
            
            // Split
            HStack(alignment: .center) {
                Image(systemName: "divide.square.fill")
                    .foregroundColor(Color.green)
                    .font(.title2)
                Spacer()
                    .frame(width: imageSpacerWidth)
                Text("Split")
                    .font(.title3)
                Spacer()
                if (model.split == "") {
                    // Model uses 1 when a split has not been provided
                    Text("1")
                        .font(.title3)
                } else {
                    Text(model.split)
                        .font(.title3)
                }
            }
            HStack {
                Button(action: {
                    model.decrementSplit()
                }) {
                    Image(systemName: "minus")
                        .font(.title3)
                }
                .disabled(!model.decrementSplitEnabled())
                Button(action: {
                    model.incrementSplit()
                }) {
                    Image(systemName: "plus")
                        .font(.title3)
                }
                .disabled(!model.incrementSplitEnabled())
            }
            .padding(.bottom)
            
            // Tip Percent
            HStack(alignment: .center) {
                Image(systemName: "arrow.up.arrow.down.square.fill")
                    .foregroundColor(Color.yellow)
                    .font(.title2)
                Spacer()
                    .frame(width: imageSpacerWidth)
                Text("Tip")
                    .font(.title3)
                Spacer()
                Text(String(format:"%0.0f%%", model.tipPercent))
                    .font(.title3)
            }
            Slider(value: $model.tipPercent, in: 10...30, step: 1)
                .padding(.bottom)
            
            // Round Up
            Toggle(isOn: $model.roundUp) {
                HStack(alignment: .center) {
                    Image(systemName: "arrow.up.square.fill")
                        .foregroundColor(Color.purple)
                        .font(.title2)
                    Spacer()
                        .frame(width: imageSpacerWidth)
                    Text("Round Up")
                        .font(.title3)
                }
            }
            .toggleStyle(SwitchToggleStyle(tint: .blue))
            .padding(.trailing)
            .padding(.bottom)
            
            // Output
            Group {
                OutputView(label: "Tip",
                           value: model.tip,
                           format: "$%0.2f")
                // Skipping tipPercent in watchOS
                OutputView(label: "Each",
                           value: model.perPerson,
                           format: "$%0.2f")
                OutputView(label: "Total",
                           value: model.total,
                           format: "$%0.2f")
            }
        }
        .navigationTitle(Text("BasicTip"))
        .fullScreenCover(isPresented: $showingBillInputView) {
            DecimalPadInputView(text: $model.bill)
        }
        .lineLimit(1)
        .minimumScaleFactor(0.1)
    }
}

struct OutputView: View {
    var label: String
    var value: Double
    var format: String
    
    var body: some View {
        Button(action: {
            // No action, using this to match the input
            // field colors above.
        }) {
            HStack(alignment: .center) {
                Text(label)
                    .font(.title3)
                Spacer()
                Text(String(format: format, value))
                    .font(.title2)
                    .bold()
            }
        }
        .disabled(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
