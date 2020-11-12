//
//  AppView.swift
//  BasicTip (macOS)
//
//  Created by Matt Gilboy on 10/21/20.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            ContentView()
        }
        .frame(width: 350)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
