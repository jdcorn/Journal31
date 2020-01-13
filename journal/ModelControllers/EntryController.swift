//
//  EntryController.swift
//  journal
//
//  Created by Jon Corn on 1/8/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import Foundation

class EntryController {
    
    // MARK: - CRUD
    static func mycreate(entryTitle: String, entryBody: String) -> Entry {
        let newEntry = Entry(entryTitle: entryTitle, bodyText: entryBody)
        return newEntry
    }
    
    static func createNewEntry(entryTitle: String, bodyText: String, toJournal journal: Journal) {
        let entry = Entry(entryTitle: entryTitle, bodyText: bodyText)
        JournalController.shared.addEntry(entry: entry, toJournal: journal)
    }
    
    static func updateEntry(entry: Entry, entryTitle: String, bodyText: String, fromJournal journal: Journal) {
        JournalController.shared.updateEntry(entry: entry, fromJournal: journal, entryTitle: entryTitle, bodyText: bodyText)
    }
}
