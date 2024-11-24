//
//  StaticQuote.swift
//  trump-quotes
//
//  Created by Mohammad Sulthan on 16/11/24.
//

import Foundation

class QuoteManager {
    private var quotesString: [String] = [
        "Make America Great Again!",
        "You're fired!",
        "I have the best words.",
        "We will make America strong again. We will make America safe again. And we will make America great again.",
        "I could stand in the middle of Fifth Avenue and shoot somebody and I wouldn't lose voters.",
        "I will be the greatest jobs president that God ever created.",
        "Nobody has more respect for women than I do.",
        "I love the poorly educated.",
        "I don’t like to brag, but I have the best brain.",
        "The beauty of me is that I'm very rich.",
        "It’s going to be great. I’m going to make it great.",
        "I’ll never tell you what I’m going to do.",
        "I don’t settle scores. I’m not like that.",
        "You're going to see a lot of great things happening in this country.",
        "I don't like to lose.",
        "Our country is in trouble.",
        "I’m a winner, and I’ll always be a winner.",
        "I think I’m the only one who knows how to fix it.",
        "The economy is doing great—better than ever before.",
        "I think I am a good judge of people.",
        "I’ve had a lot of success. I’ve had a lot of failure. I’m learning from it.",
        "I’ll make sure that people understand that I'm fighting for them.",
        "I’m the best at building things.",
        "I’m very proud of my success. And the success I’ll have for this country.",
        "We have a country that’s been taken advantage of by so many people.",
        "I want to do something great for America.",
        "I am not a politician. I am a businessman.",
        "Nobody builds better than me.",
        "I'm a deal maker, not a politician.",
        "I think we’re going to have tremendous success.",
        "I have a great relationship with the blacks.",
        "I will absolutely build the wall.",
        "I'm a fighter. I'm a tough guy.",
        "It’s all about making America great again.",
        "I think we’re going to have a big surprise on Election Day.",
        "We will have so much winning if I get elected.",
        "I'm a stable genius.",
        "I don’t need anybody’s advice.",
        "I have done more for the African American community than any president.",
        "The fake news media is the enemy of the people.",
        "I love the American people.",
        "I’m not a politician, I’m a disruptor.",
        "I have the best people working for me.",
        "The art of the deal is making things happen.",
        "The press is dishonest.",
        "I’m here to do the job, not to make friends.",
        "I don't think anybody knows more about taxes than I do.",
        "I have a lot of respect for the people who support me.",
        "I’m not running for president for me. I’m running for you.",
        "My whole life has been a fight.",
        "We are going to have a strong military.",
        "Nobody can do it better than me.",
        "I’m not a politician. I’m a businessman.",
        "This country is being taken advantage of by every nation in the world.",
        "I’m a very, very proud Republican.",
        "We’re going to make this country rich again.",
        "I’m going to get you the best deals.",
        "They said it couldn't be done, and I did it.",
        "We’re going to put America first.",
        "The economy’s booming. It’s the best it’s ever been.",
        "I’ll tell you what, I’ve never seen anything like it.",
        "The American people want change. They want things fixed.",
        "I’ll tell you one thing—I never give up.",
        "I’m going to fight for you every day.",
        "The media’s dishonest.",
        "I’m an outsider, not part of the establishment.",
        "I am the law and order candidate.",
        "I’ve had the most successful business career.",
        "It’s all about winning. We’re going to win so much.",
        "I’ve learned to surround myself with good people.",
        "I want to bring jobs back to this country.",
        "The unemployment rate is the lowest it’s been in history.",
        "We’re going to make great trade deals.",
        "We are going to win so much that you’re going to be begging for us to stop winning.",
        "Nobody knows more about politics than me.",
        "I’ve been successful in everything I’ve done.",
        "The American dream is alive again.",
        "We’re going to take back our country.",
        "I’ve got a tremendous brain, a really good brain.",
        "This is going to be the greatest country in the world.",
        "I’m the best candidate because I’m real.",
        "It’s all about the economy.",
        "We need to stop the drugs from coming into our country.",
        "I’m the best person to handle the economy.",
        "I think I’ve done an amazing job.",
        "You’re going to be so proud of me.",
        "I don’t back down.",
        "I have a fantastic relationship with the military.",
        "I’m not afraid of anyone.",
        "I don’t care what people think of me.",
        "I know more about the military than anybody.",
        "We need to make America safe again.",
        "The system is rigged, and I’m going to fix it.",
        "I’m going to get rid of the corruption.",
        "The Democrats have done nothing for the American people.",
        "I’m going to create more jobs than ever before.",
        "America needs to be respected again.",
        "I’m the best thing that’s happened to America.",
        "We will not be a pushover anymore.",
        "I’m going to bring the jobs back to America.",
    ]
    
    private let userDefaults = UserDefaults.standard
    private let shuffledQuotesKey = "shuffledQuotes"
    private let currentQuoteIndexKey = "currentQuoteIndex"
    private let lastShownDateKey = "lastShownDate"
    
    init() {
        if userDefaults.array(forKey: shuffledQuotesKey) == nil {
            reshuffleQuotes()
        }
    }
    
    private func reshuffleQuotes() {
        let shuffledQuotes = quotesString.shuffled()
        userDefaults.set(shuffledQuotes, forKey: shuffledQuotesKey)
        userDefaults.set(0, forKey: currentQuoteIndexKey)
    }
    
    func getTodaysQuote() -> String {
        let today = getCurrentDate()
        let lastShownDate = userDefaults.string(forKey: lastShownDateKey)
        
        if lastShownDate != today {
            moveToNextQuote()
            userDefaults.set(today, forKey: lastShownDateKey)
        }
        
        let currentQuoteIndex = userDefaults.integer(forKey: currentQuoteIndexKey)
        let shuffledQuotes = userDefaults.array(forKey: shuffledQuotesKey) as? [String] ?? []
        
        guard !shuffledQuotes.isEmpty else {
            return "No quotes available!"
        }
        
        return shuffledQuotes[currentQuoteIndex]
    }
     
    private func moveToNextQuote() {
        var currentQuoteIndex = userDefaults.integer(forKey: currentQuoteIndexKey)
        currentQuoteIndex += 1
         
        let shuffledQuotes = userDefaults.array(forKey: shuffledQuotesKey) as? [String] ?? []
        if currentQuoteIndex >= shuffledQuotes.count {
            reshuffleQuotes()
            currentQuoteIndex = 0
        }
         
        userDefaults.set(currentQuoteIndex, forKey: currentQuoteIndexKey)
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}
