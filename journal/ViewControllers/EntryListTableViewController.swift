//
//  EntryListTableViewController.swift
//  journal
//
//  Created by Jon Corn on 1/8/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    // MARK: - Properties
    var journalLanding: Journal?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(journalLanding)
        self.title = journalLanding?.journalName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /// Unwrapping
        return journalLanding?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        /// Unwrapping
        guard let journal = self.journalLanding else { return UITableViewCell() }

        let entry = journal.entries[indexPath.row]
        
        cell.textLabel?.text = entry.entryTitle
        cell.detailTextLabel?.text = "\(entry.timestamp)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            /// Unwrapping
            guard let journal = self.journalLanding else { return }
            
            let entry = journal.entries[indexPath.row]
            JournalController.shared.removeEntry(entry: entry, fromJournal: journal)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddEntry" {
            guard let destinationVC = segue.destination as? EntryDetailViewController else { return }
            guard let journal = self.journalLanding else { return }
            destinationVC.journal = journal
        }
        
        
        if segue.identifier == "toEntryDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? EntryDetailViewController else { return }
            guard let journal = self.journalLanding else { return }
            let entry = journal.entries[indexPath.row]
            destinationVC.entryLanding = entry
            destinationVC.journal = journalLanding
        }
    }
}
