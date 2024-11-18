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
    @State private var todaysQuote: String = ""
    private let quoteManager = QuoteManager()

    var body: some View {
        if #available(iOS 17.0, *) {
            NavigationStack {
                VStack {
                    Image(uiImage: UIImage(named: "trump-shot")!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding()

                    Spacer()
                        .frame(height: 4)

                    VStack {
                        Text(todaysQuote)
                            .font(.custom("Noteworthy-Light", size: 28))
                            .multilineTextAlignment(.center)
                            .padding()
                            .italic()

                        Spacer()
                            .frame(height: 16)

                        Text("Donald J. Trump")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .italic()
                            .padding()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color.black.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.vertical)
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .navigationTitle("Trump Quotes")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
                    if isLoading {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                print("Loading button tapped!")
                            }) {
                                Image(systemName: "circle.fill")
                                    .foregroundStyle(.green)
                            }
                        }
                    } else {
                        ToolbarItem(placement: .topBarLeading) {
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

                    ToolbarItem(placement: .topBarTrailing) {
                        let link = URL(string: "https://google.com")!
                        ShareLink(item: link, message: Text(todaysQuote))
                        Image(systemName: "link.circle")
                            .padding()
                        Text("Share this website")
                    }
                }
            }
            .onAppear {
                isLoading = true
                loadTodaysQuote()
            }
        } else {}
    }

    private func loadTodaysQuote() {
        todaysQuote = quoteManager.getTodaysQuote()
    }

    private func refreshQuote() {
        todaysQuote = quoteManager.getTodaysQuote()
    }
}

#Preview {
    ContentView()
}
