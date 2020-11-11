//
//  AppView.swift
//  BasicTip (iOS)
//
//  Created by Matt Gilboy on 11/11/20.
//  Copyright © 2020 Matt Gilboy. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        // ScrollView fixes screenshift, scrolling is disabled
        // because it really isn't needed...
        ScrollView([], showsIndicators: false) {
            ZStack {
                BackgroundView()
                ContentView()
            }
        }
        .ignoresSafeArea(
            .keyboard,
            // If iPad, allow keyboard to adjust safe area
            edges: UIDevice.current.userInterfaceIdiom == .pad ?
                [] : .bottom
        )
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
