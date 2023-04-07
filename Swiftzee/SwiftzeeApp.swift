//
//  SwiftzeeApp.swift
//  Swiftzee
//
//  Created by Antonio on 2023-04-03.
//

import SwiftUI

@main
struct SwiftzeeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(selectedSize: 6, humanOpponent: true)
        }
    }
}
