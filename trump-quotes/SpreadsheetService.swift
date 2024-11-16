//
//  SpreadsheetService.swift
//  trump-quotes
//
//  Created by Mohammad Sulthan on 16/11/24.
//

import Foundation

class CSVParser {
    static func parseCSV(from data: String) -> [String] {
        let parsedCSV: [String] = data.components(separatedBy: "\n").map{ $0.components(separatedBy: ",")[0] }
        return parsedCSV
    }
}

class SpreadsheetService: ObservableObject {
    @Published var quotes: [Quote] = []
    
    private let spreadsheetURL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vRl3d_opI8y_nilK07Jo7uOCYhTIKQqTLu3IFwJodtzr-B7CqtBNCmTp0vlV1Z0yTnxgoyl57Igs0dT/pub?gid=0&single=true&output=csv"
    
    func fetchQuotes () {
        guard let url = URL(string: spreadsheetURL) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching CSV: \(error.localizedDescription)")
                return
            }

            guard let data = data, let csvString = String(data: data, encoding: .utf8) else {
                print("No data or unable to decode")
                return
            }

        
            let rows = CSVParser.parseCSV(from: csvString)
            
            DispatchQueue.main.async {
                self.parseCSV(csvString)
               }

            print(rows)
        }.resume()
    }
    
    func cleanQuote(_ text: String) -> String {
        text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "\\\"", with: "\"")
            .replacingOccurrences(of: "\r", with: "")
            .trimmingCharacters(in: CharacterSet(charactersIn: "\""))
    }
    
    private func parseCSV(_ csvString: String) {
        let rows = CSVParser.parseCSV(from: csvString)

        self.quotes = rows.compactMap { row -> Quote? in
            return Quote(quote: cleanQuote(row))
        }
    }
}

struct GoogleSpreadsheetResponse: Codable {
    let values: [[String]]
}
