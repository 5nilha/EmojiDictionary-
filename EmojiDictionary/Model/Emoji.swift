//
//  Emoji.swift
//  EmojiDictionary
//
//  Created by Fabio Quintanilha on 12/17/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//

import Foundation

class Emoji : Codable {
    
    var symbol : String
    var name : String
    var description : String
    var usage : String
    
    init (symbol : String, name : String, description : String, usage : String) {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
    
    static private func documentPathURL() -> URL {
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let pathURL = documentPath.appendingPathExtension("Emoji").appendingPathExtension("plist")
        
        return pathURL
    }
    
    static func saveToFile(emojies : [Emoji]) {
        
        let listEncoder = PropertyListEncoder()
        
        if let encodedEmojies = try? listEncoder.encode(emojies) {
            try? encodedEmojies.write(to: documentPathURL(), options: .noFileProtection)
        }
    }
    
    static func loadFromFile() -> [Emoji] {
    
        let listDecoder = PropertyListDecoder()
      
        if let retrieveEmojies = try? Data(contentsOf: documentPathURL()) {
            if let decodedEmojies = try? listDecoder.decode([Emoji].self, from: retrieveEmojies) {
                return decodedEmojies
            }
        }
        
        return []
        
    }
    
    static func loadSampleEmojies() -> [Emoji] {
        
        let sample : [Emoji] = [
            Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
            Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
            Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
            Emoji(symbol: "👮", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
            Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
            Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
            Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
            Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
            Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
            Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
            Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"), Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
            Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
        ]
        
        return sample
    }
    
    
}
