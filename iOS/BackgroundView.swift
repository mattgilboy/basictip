//
//  SplashScreen.swift
//  TipCalculator
//
//  Created by Matt Gilboy on 8/3/20.
//  Copyright © 2020 Matt Gilboy. All rights reserved.
//

import SwiftUI

struct BackgroundView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            if colorScheme == .dark {
                Color.black
            } else {
                Color.white
            }
        }
        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
        .ignoresSafeArea(.container)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
