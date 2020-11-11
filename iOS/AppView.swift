//
//  AppView.swift
//  BasicTip (iOS)
//
//  Created by Matt Gilboy on 10/21/20.
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
