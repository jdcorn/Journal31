//
//  JournalController.swift
//  journal
//
//  Created by Jon Corn on 1/8/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import Foundation

class JournalController {
    
    // MARK: - Properties
    static let shared = JournalController()
    var journals = [Journal]()
    init() {
        loadFromPersistentStore()
    }
    
    // MARK: - CRUD
    func createJournal(journalName: String) {
        let journal = Journal(journalName: journalName)
        journals.append(journal)
        saveToPersistentStore()
    }
    
    func removeJournal(journal: Journal) {
        if let index = journals.firstIndex(of: journal) {
            journals.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    func addEntry(entry: Entry, toJournal journal: Journal) {
        journal.entries.append(entry)
        saveToPersistentStore()
    }
    
    func removeEntry(entry: Entry, fromJournal journal: Journal) {
        guard let index = journal.entries.firstIndex(of: entry) else { return }
        journal.entries.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, fromJournal journal: Journal, entryTitle: String, bodyText: String) {
        entry.entryTitle = entryTitle
        entry.bodyText = bodyText
        saveToPersistentStore()
    }
    
    //  MARK: - Persistence
    func fileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        let filename = "JournalSaved.json"
        let fullURL = documentDirectory.appendingPathComponent(filename)
        return fullURL
    }
    
    func saveToPersistentStore() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(journals)
            try data.write(to: fileURL())
        } catch let error {
            print(error)
        }
    }
    
    func loadFromPersistentStore() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let journals = try decoder.decode([Journal].self, from: data)
            self.journals = journals
        } catch let error {
            print(error)
        }
    }
}
