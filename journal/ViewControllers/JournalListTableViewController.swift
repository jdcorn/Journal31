//
//  JournalListTableViewController.swift
//  journal
//
//  Created by Jon Corn on 1/8/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import UIKit

class JournalListTableViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var journalNameTextField: UITextField!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func addJournalButtonTapped(_ sender: Any) {
        guard let journalName = journalNameTextField.text, !journalName.isEmpty else { return }
        JournalController.shared.createJournal(journalName: journalName)
        journalNameTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.shared.journals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        let journal = JournalController.shared.journals[indexPath.row]
        cell.textLabel?.text = journal.journalName
        cell.detailTextLabel?.text = "\(journal.entries.count) entries"
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let journal = JournalController.shared.journals[indexPath.row]
            JournalController.shared.removeJournal(journal: journal)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEntryList" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? EntryListTableViewController else {return}
            let journal = JournalController.shared.journals[indexPath.row]
            destinationVC.journalLanding = journal
        }
    }
}
