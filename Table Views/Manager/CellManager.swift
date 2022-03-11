//
//  CellManager.swift
//  Table Views
//
//  Created by notwo on 3/9/22.
//
import UIKit

class CellManager {
    func configure(_ cell: EmojiCell, with emoji: Emoji) {
        cell.symbolLabel.text = emoji.symbol
        cell.nameLabel.text = emoji.name
        cell.descriptionLabel.text = emoji.description
    }
}
