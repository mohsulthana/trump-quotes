//
//  Settings.swift
//  trump-quotes
//
//  Created by Mohammad Sulthan on 20/11/24.
//

import Combine
import SwiftUI
import UserNotifications

class NotificationManager {
    static let instance = NotificationManager() // Singleton
    @Published var message: String = ""
    
    @State private var todaysQuote: String = ""
    private let quoteManager = QuoteManager()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { _, error in
            if let error = error {
                print("ERROR: \(error)")
            } else {
                self.scheduleDailyNotification()
            }
        }
    }
    
    func scheduleDailyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Donald J Trump:"
        content.subtitle = quoteManager.getTodaysQuote()
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct Settings: View {
    @State private var isNotificationOn = false
    var body: some View {
        NavigationView {
            List {
                Section(
                    header: Text("General Settings"),
                    footer: Text("This will allow you get daily quote at 9:00 AM")
                ) {
                    Toggle("Turn on notification", isOn: $isNotificationOn)
                        .toggleStyle(SwitchToggleStyle())
                        .tint(Color.accentColor)
                        .onChange(of: isNotificationOn) { _isNotificationOn in
                            if _isNotificationOn {
                                NotificationManager.instance.requestAuthorization()
                            } else {
                                stopNotification()
                            }
                        }
                }
            }
            .navigationTitle("Settings")
            .listStyle(InsetGroupedListStyle())
        }
    }
    
    func stopNotification() {
        NotificationManager.instance.cancelNotification()
    }
}

#Preview {
    Settings()
}
