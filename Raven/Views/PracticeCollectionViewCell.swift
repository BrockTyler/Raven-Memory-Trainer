//
//  PracticeCollectionViewCell.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import UIKit

class PracticeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    
    var wasTapped: Bool?
    
    var word: String? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        
        guard let word = word else { return }
        
        if (word.contains("_")) && (self.wasTapped == false) /*(state == .normal) */ {
            self.wordLabel.text = word
            self.wordLabel.backgroundColor = UIColor.clear
            self.wordLabel.textColor = .black
            self.wordLabel.font = UIFont(name: "Courier", size: 17)
            self.wordLabel.clipsToBounds = true
            self.wordLabel.layer.borderWidth = 0.3
            self.wordLabel.layer.cornerRadius = 5
            self.wordLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        } else if (!word.contains("_")) && (self.wasTapped == true) {
            self.wordLabel.text = word
            self.wordLabel.backgroundColor = #colorLiteral(red: 1, green: 0.674555669, blue: 0.3397028366, alpha: 1)
            self.wordLabel.textColor = .black
            self.wordLabel.font = UIFont(name: "Courier", size: 17)
            self.wordLabel.clipsToBounds = true
            self.wordLabel.layer.borderWidth = 0.3
            self.wordLabel.layer.cornerRadius = 5
            self.wordLabel.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
        } else {
            self.wordLabel.backgroundColor = .clear
            self.wordLabel.textColor = .black
            self.wordLabel.font = UIFont(name: "Courier", size: 17)
            self.wordLabel.text = word
            self.wordLabel.layer.borderWidth = 0.0
        }
    }
    
}
