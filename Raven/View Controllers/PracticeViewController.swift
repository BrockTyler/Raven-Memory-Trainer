//
//  PracticeViewController.swift
//  Raven
//
//  Created by brock tyler on 6/11/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import UIKit

class PracticeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var blanksSliderLabel: UILabel!
    @IBOutlet weak var blankSlider: UISlider!
    @IBOutlet weak var practiceCollectionView: UICollectionView!
    @IBOutlet weak var shuffleBlanksButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var editBarButtonItem: UIBarButtonItem!
    
    var passage: Passage?
    var displayArr: [String] = []
    var trueArr: [String] = []
    var revealed: String = "broken"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let passage = passage else { return }
        self.passage = passage
        
        guard let text = passage.text else { return }
        let percent = blankSlider.value
        let displayPercent = (Int(percent * 100))
        blanksSliderLabel.text = "\(displayPercent)%"
        
        displayArr = BlankCreator.shared.initBlankArrWithRandomization(text: text, percent: percent)
        trueArr = BlankCreator.shared.getNonBlankArray(text: text)
        
        updateViews()
        
        practiceCollectionView.dataSource = self
        practiceCollectionView.delegate = self
        
        PassageController.updatePracticeDate(passage: passage)
        PassageController.updateWasPracticed(passage: passage, updatedStatus: true)
    }
    
    // MARK: - Actions
    
    @IBAction func sliderMoved(_ sender: Any) {
        let percent = blankSlider.value
        displayArr = BlankCreator.shared.changeNumBlanks(percent: percent)
        let displayPercent = (Int(percent * 100))
        blanksSliderLabel.text = "\(displayPercent)%"
        practiceCollectionView.reloadData()
    }
    
    @IBAction func shuffleBlanksButtonTapped(_ sender: Any) {
        guard let text = passage?.text else { return }
        let percent = blankSlider.value
        displayArr = BlankCreator.shared.initBlankArrWithRandomization(text: text, percent: percent)
        practiceCollectionView.reloadData()
    }
    
    // MARK: - CollectionView Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return displayArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let string = displayArr[indexPath.item]
        let attributes = [NSAttributedStringKey.font: UIFont(name: "Courier", size: 17)]
        var labelSize = string.size(withAttributes: attributes)
        
        labelSize.width *= 1.1
        labelSize.height *= 1.3
        
        return labelSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "practiceCell", for: indexPath) as? PracticeCollectionViewCell else { return UICollectionViewCell() }
        
        if revealed != "broken" {
            cell.word = revealed
        } else {
            cell.wasTapped = false
            let word = displayArr[indexPath.item]
            cell.word = word
        }
        
        revealed = "broken"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "practiceCell", for: indexPath) as? PracticeCollectionViewCell else { return }
        
        let revealedWord = trueArr[indexPath.item]
        
        cell.wasTapped = true
        revealed = revealedWord
        
        collectionView.reloadItems(at: [indexPath])
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEditView" {
            
            guard let passage = passage else { return }
            
            if let destinationVC = segue.destination as? AddViewController {
                    destinationVC.passage = passage
            }
        }
    }
    
    // MARK: - Helper Methods
    
    func updateViews() {
        
        self.title = "Practice"
        self.view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        shuffleBlanksButton.backgroundColor = .white
        shuffleBlanksButton.layer.cornerRadius = 10
        shuffleBlanksButton.clipsToBounds = true
        shuffleBlanksButton.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        shuffleBlanksButton.layer.borderWidth = 1.0
        shuffleBlanksButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        practiceCollectionView.layer.cornerRadius = 5
        practiceCollectionView.clipsToBounds = true
        practiceCollectionView.layer.borderWidth = 1.0
        practiceCollectionView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        blanksSliderLabel.textColor = .black
        
        titleLabel.backgroundColor = .white
        titleLabel.layer.borderWidth = 0.0
        titleLabel.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.text = passage?.title
        
        blankSlider.backgroundColor = .white
        blankSlider.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
}
