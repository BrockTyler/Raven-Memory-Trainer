//
//  AddViewController.swift
//  Raven
//
//  Created by brock tyler on 5/23/18.
//  Copyright © 2018 Brock Tyler. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextViewDelegate {
    
    var passage: Passage?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var textTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupViews()
        
        textTextView.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        if let passage = passage {
            titleTextField.text = passage.title
            textTextView.text = passage.text
        }
    }
    
    func setupViews() {
        
        title = "Add Passage"
        self.view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        clearButton.backgroundColor = .white
        clearButton.layer.cornerRadius = 10
        clearButton.clipsToBounds = true
        clearButton.tintColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        clearButton.layer.borderWidth = 1.0
        clearButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        textTextView.layer.cornerRadius = 5
        textTextView.clipsToBounds = true
        textTextView.layer.borderWidth = 1.0
        textTextView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        titleTextField.layer.cornerRadius = 5
        titleTextField.clipsToBounds = true
        titleTextField.layer.borderWidth = 1.0
        titleTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
    }
    
    // MARK: - Button Actions
    
    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        
        
        guard let title = titleTextField.text, !title.isEmpty,
            let text = textTextView.text,
            !text.isEmpty else { return }
        
        if let passage = self.passage {
            PassageController.editPassage(passage: passage, title: title, text: text)
        } else {
            PassageController.addPassage(title: title, text: text)
        }
        
        let _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func clearButtonTapped(_ sender: AnyObject) {
        
        titleTextField.text = ""
        textTextView.text = ""
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textTextView.text.contains("Tap here to type or paste in your text.")) {
            textTextView.text = ""
        }
    }
}


