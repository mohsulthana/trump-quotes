//
//  ContentView.swift
//  trump-quotes
//
//  Created by Mohammad Sulthan on 16/11/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var service = SpreadsheetService()
    
    var body: some View {
        NavigationStack {
            Image(uiImage: UIImage(named: "trump-shot")!)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding()
            
            if service.quotes.isEmpty {
                Text("No quotes available")
                    .foregroundStyle(.gray)
                    .italic()
            } else {
                Section {
                    List($service.quotes) { $quote in
                           VStack(alignment: .leading) {
                               Text(quote.quote)
                                   .font(.headline)
                           }
                       }
                    .navigationTitle("Trump Quotes")
                    .navigationBarTitleDisplayMode(.automatic)
                }
            }
        }
        .onAppear {
            service.fetchQuotes()
        }
    }
}

#Preview {
    ContentView()
}
