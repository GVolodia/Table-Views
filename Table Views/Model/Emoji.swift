//
//  Emoji.swift
//  Table Views
//
//  Created by notwo on 3/9/22.
//

import Foundation
struct Emoji: Codable {
    var symbol: String
    var name: String
    var description: String
    var usage: String
    
    init(symbol: String = "", name: String = "", description: String = "", usage: String = "") {
        self.symbol = symbol
        self.name = name
        self.description = description
        self.usage = usage
    }
}

extension Emoji {
    static var all: [Emoji] {
        return [
            Emoji(symbol: "⭐️", name: "Звезда", description: "Желтая пятиконечная звезда", usage: "Когда что-то нравится"),
            Emoji(symbol: "🐶", name: "Собака", description: "Мордочка собаки", usage: "Что-то дружелюбное"),
            Emoji(symbol: "✅", name: "Галочка", description: "Галочка на зеленом фоне", usage: "Дело сделано"),
            Emoji(symbol: "⛔️", name: "Стоп", description: "Знак СТОП", usage: "Проезд запрещен!"),

        ]
    }
    
    static func loadAll() -> [Emoji]? {
        return nil
    }
    
    static func loadDefault() -> [Emoji] {
        return all
    }
}
