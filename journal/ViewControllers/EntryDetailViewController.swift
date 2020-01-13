//
//  EntryDetailViewController.swift
//  journal
//
//  Created by Jon Corn on 1/8/20.
//  Copyright © 2020 jdcorn. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - Properties
    var journal: Journal?
    var entryLanding: Entry? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func clearButtonTapped(_ sender: Any) {
        entryTitleTextField.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = entryTitleTextField.text,
            let body = bodyTextView.text,
            !title.isEmpty,
            !body.isEmpty,
            let journal = journal
            else { return }
        
        if entryLanding == nil {
            let entry = Entry(entryTitle: title, bodyText: body)
            JournalController.shared.addEntry(entry: entry, toJournal: journal)
        } else {
            guard let entry = entryLanding
                else { return }
            JournalController.shared.updateEntry(entry: entry, fromJournal: journal, entryTitle: title, bodyText: body)
        }
        navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddEntry" {
            guard let destinationVC = segue.destination as? EntryDetailViewController else { return }
            destinationVC.journal = journal
        }
    }
    
    // MARK: - Functions
    func updateViews () {
        loadViewIfNeeded()
        if let entry = entryLanding {
            entryTitleTextField.text = entry.entryTitle
            bodyTextView.text = entry.bodyText
        }
    }
}
