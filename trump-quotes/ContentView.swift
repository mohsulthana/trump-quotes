//
//  ContentView.swift
//  trump-quotes
//
//  Created by Mohammad Sulthan on 16/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var tabSelection = 1

    var body: some View {
        TabView(selection: $tabSelection) {
            TodayQuote().tabItem {
                Image(systemName: "text.quote")
                Text("Today's Quote")
            }.tag(1)

            Settings().tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }.tag(2)
        }
    }
}

#Preview {
    ContentView()
}
