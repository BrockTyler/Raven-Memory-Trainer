//
//  PassageTableViewCell.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import UIKit

class PassageTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    
    var passage: Passage? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
        guard let passage = passage else { return }
        
        var displayDate = ""
        
        if passage.wasPracticed == false && PassageListTableViewController.practiceView == false {
            if let date = passage.creationDate {
                displayDate = "\(date)"
                displayDate = DateHelper.dateFormatter.string(from: date)
                creationDateLabel.textColor = .black
            }
        } else if passage.wasPracticed == false && PassageListTableViewController.practiceView == true {
            if let date = passage.creationDate {
                displayDate = "Not Practiced"
                creationDateLabel.textColor = .red
            }
        } else if passage.wasPracticed == true && PassageListTableViewController.practiceView == true {
            if let date = passage.practiceDate {
                displayDate = "\(date)"
                displayDate = "Practiced on: \(DateHelper.dateFormatter.string(from: date))"
                creationDateLabel.textColor = .black
            }
        } else {
            if let date = passage.creationDate {
                displayDate = "\(date)"
                displayDate = DateHelper.dateFormatter.string(from: date)
                creationDateLabel.textColor = .black
            }
        }
        
        titleLabel.text = passage.title
        creationDateLabel.text = displayDate
        
    }
}
