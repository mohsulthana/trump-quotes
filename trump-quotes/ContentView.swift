//
//  ContentView.swift
//  trump-quotes
//
//  Created by Mohammad Sulthan on 16/11/24.
//

//https:docs.google.com/spreadsheets/d/e/2PACX-1vRl3d_opI8y_nilK07Jo7uOCYhTIKQqTLu3IFwJodtzr-B7CqtBNCmTp0vlV1Z0yTnxgoyl57Igs0dT/pub?gid=0&single=true&output=csv

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            Image(uiImage: UIImage(named: "trump-shot")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding()
            
            Form {
                Section {
                    Text("Hello, world!")
                }
            }
            .navigationTitle("Trump Quotes")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    ContentView()
}
