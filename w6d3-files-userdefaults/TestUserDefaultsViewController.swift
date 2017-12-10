//
//  TestUserDefaultsViewController.swift
//  w6d3-files-userdefaults
//
//  Created by Roland on 2017-12-09.
//  Copyright © 2017 Roland. All rights reserved.
//

import UIKit

class TestUserDefaultsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var highScoreTextField: UITextField!
    
    // MARK: - IBActions
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismissKeyboard()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveUserPreferences()
        dismissKeyboard()
    }
}

// MARK: - UIViewController methods
extension TestUserDefaultsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadUserPreferences()
    }
}

// MARK: - Private methods
extension TestUserDefaultsViewController {
    
    private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func loadUserPreferences() {
        // Load user preferences
        nameTextField.text = UserDefaults.standard.string(forKey: "username")
        highScoreTextField.text = UserDefaults.standard.string(forKey: "highScore")
    }
    
    private func saveUserPreferences() {
        // Save user preferences
        let newNameValue = (nameTextField.text?.isEmpty == false) ? nameTextField.text : ""
        UserDefaults.standard.set(newNameValue, forKey: "username")
        let newHighScoreValue = (highScoreTextField.text?.isEmpty == false) ? highScoreTextField.text : ""
        UserDefaults.standard.set(newHighScoreValue, forKey: "highScore")
    }
}
