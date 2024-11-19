//
//  ContentView.swift
//  trump-quotes
//
//  Created by Mohammad Sulthan on 16/11/24.
//

import SwiftUI

struct ImageOverlay: View {
    var quote: String

    var body: some View {
        VStack {
            Text(quote)
                .font(.title)
                .padding(.horizontal, 5)
                .foregroundStyle(.white)

            Spacer()
                .frame(height: 4)

            Text("Donald J. Trump")
                .font(.callout)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .italic()
                .padding()
                .foregroundStyle(.white)
        }
        .background(Color.accentColor)
        .opacity(0.8)
        .cornerRadius(8)
        .padding(8)
    }
}

struct ContentView: View {
    @State private var isLoading: Bool = false
    @StateObject private var service = SpreadsheetService()

    @State private var todaysQuote: String = ""
    private let quoteManager = QuoteManager()

    @State private var showingSheet = false

    var body: some View {
        if #available(iOS 17.0, *) {
            NavigationStack {
                VStack {
                    Image(uiImage: UIImage(named: "trump-shot")!)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .padding()

                    Spacer()
                        .frame(height: 4)

                    VStack {
                        Text(todaysQuote)
                            .font(.largeTitle)
                            .multilineTextAlignment(.center)
                            .padding()
                            .italic()
                            .foregroundStyle(Color.white)

                        Spacer()
                            .frame(height: 16)

                        Text("Donald J. Trump")
                            .font(.footnote)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .italic()
                            .padding()
                            .foregroundStyle(Color.white)
                    }
                    .background(Color.accentColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding(.vertical)
                    .padding(.horizontal)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .navigationTitle("Today Quote")
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar {
//                    if isLoading {
//                        ToolbarItem(placement: .topBarLeading) {
//                            Button(action: {
//                                print("Loading button tapped!")
//                            }) {
//                                Image(systemName: "circle.fill")
//                                    .foregroundStyle(.green)
//                            }
//                        }
//                    } else {
//                        ToolbarItem(placement: .topBarLeading) {
//                            Button(action: {
//                                isLoading = true
//                                Task {
//                                    await service.fetchQuotes()
//                                }
//                                isLoading = false
//                            }) {
//                                Image(systemName: "arrow.triangle.2.circlepath")
//                            }
//                        }
//                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        ShareLink(
                            item: renderQuotedImage(),
                            preview: SharePreview("Donald J. Trump", image: renderQuotedImage()) // Optional preview
                        ) {
                            Label("Share Content", systemImage: "square.and.arrow.up")
                                .font(.headline)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            .onAppear {
                loadTodaysQuote()
            }
        } else {}
    }

    private func renderQuotedImage() -> Image {
        let renderer = ImageRenderer(content: ZStack {
            Image("trump-shot")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)

            Color.black.opacity(0.2)

            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .cornerRadius(6)
        .overlay(
            VStack {
                Spacer()
                ImageOverlay(quote: todaysQuote)
                    .padding(.bottom, 24)
                    .cornerRadius(16)
            }
        )
        )

        return Image(uiImage: renderer.uiImage!)
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
