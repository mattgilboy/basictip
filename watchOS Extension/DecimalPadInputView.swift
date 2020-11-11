//
//  DecimalPadInputView.swift
//  watchOS Extension
//
//  Created by Matt Gilboy on 11/11/20.
//  Copyright © 2020 Matt Gilboy. All rights reserved.
//

import SwiftUI

let buttonColor = Color(red: 0.075, green: 0.075, blue: 0.075)

struct DecimalPadInputView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var text: String
    
    var body: some View {
        VStack {
            Group {
                if (text.isEmpty) {
                    Text("Enter Bill Amount")
                } else {
                    Text(text)
                        .bold()
                }
            }
            .padding(.horizontal)

            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("1")
                    }) {
                        Text("1")
                            .bold()
                    }
                    .frame(height: 0)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("2")
                    }) {
                        Text("2")
                            .bold()
                    }
                    .frame(height: 0)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("3")
                    }) {
                        Text("3")
                            .bold()
                    }
                    .frame(height: 0)
                }
            }

            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("4")
                    }) {
                        Text("4")
                            .bold()
                    }
                    .frame(height: 0)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("5")
                    }) {
                        Text("5")
                            .bold()
                    }
                    .frame(height: 0)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("6")
                    }) {
                        Text("6")
                            .bold()
                    }
                    .frame(height: 0)
                }
            }

            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("7")
                    }) {
                        Text("7")
                            .bold()
                    }
                    .frame(height: 0)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("8")
                    }) {
                        Text("8")
                            .bold()
                    }
                    .frame(height: 0)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("9")
                    }) {
                        Text("9")
                            .bold()
                    }
                    .frame(height: 0)
                }
            }
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                        .onTapGesture {
                            // Difficult to tap '.' without this
                            if (text.rangeOfCharacter(from: ["."]) == nil) {
                                text.append(".")
                            }
                        }
                    Button(action: {
                        text.append(".")
                    }) {
                        Text(".")
                            .bold()
                    }
                    .frame(height: 0)
                    .disabled(text.rangeOfCharacter(from: ["."]) != nil)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(buttonColor)
                    Button(action: {
                        text.append("0")
                    }) {
                        Text("0")
                            .bold()
                    }
                    .frame(height: 0)
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 8.0)
                        .foregroundColor(.clear)
                    Button(action: {
                        if (!text.isEmpty) {
                            text.removeLast()
                        }
                    }) {
                        Image(systemName: "delete.left")
                    }
                    .frame(height: 0)
                    .disabled(text.isEmpty)
                }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 8.0)
                    .foregroundColor(.clear)
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .foregroundColor(.blue)
                }
                .frame(height: 0)
            }
        }
        .buttonStyle(PlainButtonStyle())
        .font(.title3)
        .lineLimit(1)
        .minimumScaleFactor(0.1)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}

struct DecimalPadInputView_Previews: PreviewProvider {
    static var previews: some View {
        DecimalPadInputView(text: .constant(""))
    }
}
