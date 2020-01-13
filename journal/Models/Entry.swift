//
//  Entry.swift
//  journal
//
//  Created by Jon Corn on 1/8/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import Foundation

class Entry: Codable {
    
    var timestamp: Date = Date()
    var entryTitle: String
    var bodyText: String
    
    init(timestamp: Date = Date(), entryTitle: String, bodyText: String) {
        self.timestamp = timestamp
        self.entryTitle = entryTitle
        self.bodyText = bodyText
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.timestamp == rhs.timestamp && lhs.entryTitle == rhs.entryTitle && lhs.bodyText == rhs.bodyText
    }
}
