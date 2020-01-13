//
//  Journal.swift
//  journal
//
//  Created by Jon Corn on 1/8/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import Foundation

class Journal: Codable {
    
    var entries: [Entry]
    let journalName: String
    
    init(entries: [Entry] = [], journalName: String) {
        self.entries = entries
        self.journalName = journalName
    }
}

extension Journal: Equatable {
    static func == (lhs: Journal, rhs: Journal) -> Bool {
        return lhs.entries == rhs.entries && lhs.journalName == rhs.journalName
    }
}
