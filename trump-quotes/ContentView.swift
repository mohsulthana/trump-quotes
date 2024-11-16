//
//  ContentView.swift
//  trump-quotes
//
//  Created by Mohammad Sulthan on 16/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoading = false
    @State private var searchText = ""
    @StateObject private var service = SpreadsheetService()
    private var quotes: [Quote] = quotesData

    var body: some View {
        NavigationStack {
            VStack {
                Image(uiImage: UIImage(named: "trump-shot")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()

                if service.quotes.isEmpty {
                    List(quoteResults) { quote in
                        VStack(alignment: .leading) {
                            Text(quote.quote)
                                .font(.headline)
                        }
                        .padding(.vertical, 4)
                        .transition(.opacity.combined(with: .slide))
                    }
                } else {
                    List(quoteResults) { quote in
                        VStack(alignment: .leading) {
                            Text(quote.quote)
                                .font(.headline)
                        }
                        .padding(.vertical, 4)
                        .transition(.opacity.combined(with: .slide))
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("Trump Quotes")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                if isLoading {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            print("Loading button tapped!")
                        }) {
                            Image(systemName: "circle.fill")
                                .foregroundStyle(.green)
                        }
                    }
                } else {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            Task {
                                isLoading = true
                                await service.fetchQuotes()
                                isLoading = false
                            }
                        }) {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                    }
                }
            }
        }

        .searchable(text: $searchText, prompt: "Search quote")
        .onAppear {
            isLoading = true
            Task {
                await service.fetchQuotes()
                isLoading = false
            }
        }
        .onChange(of: searchText) { _, _ in
            withAnimation {
                _ = quoteResults
            }
        }
    }

    var quoteResults: [Quote] {
        if searchText.isEmpty {
            return quotes
        } else {
            return quotes.filter { $0.quote.localizedStandardContains(searchText) }
        }
    }
}

#Preview {
    ContentView()
}
