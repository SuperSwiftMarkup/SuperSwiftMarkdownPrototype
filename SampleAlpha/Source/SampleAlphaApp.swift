//
//  SampleAlphaApp.swift
//  SampleAlpha
//
//  Created by Colbyn Wadman on 1/14/25.
//

import SwiftUI
import CoreTextKit


@main
struct SampleAlphaApp: App {
    var body: some Scene {
        WindowGroup {
//            Text("TODO")
            DocumentDisplayView()
                .preferredColorScheme(.light)
                .environment(\.colorScheme, .light)
        }
    }
}
