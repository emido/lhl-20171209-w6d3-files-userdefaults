//
//  TestFilesViewController.swift
//  w6d3-files-userdefaults
//
//  Created by Roland on 2017-12-08.
//  Copyright © 2017 Roland. All rights reserved.
//

import UIKit

class TestFilesViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var textView: UITextView!
    
    // MARK: - Private properties
    private lazy var filePath: String = {
        // Get user's documents directory
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

        // Get user's documents directory
        if let documentsPath = directories.first {
            // Generate filepath of file
            let filePath = (documentsPath as NSString).appendingPathComponent("appData")
            return filePath
        }
        else {
            return ""
        }
    }()
    
    // MARK: - IBActions
    @IBAction func loadButtonTapped(_ sender: UIButton) {
        loadFile()
        dismissKeyboard()
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        saveFile()
        dismissKeyboard()
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismissKeyboard()
    }
}

// MARK: - UIViewController methods
extension TestFilesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadFile()
    }
}

// MARK: - Private methods
extension TestFilesViewController {
    
    private func loadFile() {
        // Check if file exists
        if !FileManager.default.fileExists(atPath: filePath) {
            // File does not exist, blank out text view
            textView.text = "";
            return
        }

        // File exists, load contents of file into textView
        do {
            let fileContents = try String(contentsOfFile: filePath, encoding: .utf8)
            textView.text = fileContents
        }
        catch {
            // Error in loading file
            textView.text = ""
        }
    }
    
    private func saveFile() {
        // Check if file exists
        if FileManager.default.fileExists(atPath: filePath) {
            // File exists, delete it
            do {
                try FileManager.default.removeItem(atPath: filePath)
            }
            catch {
                print("Could not delete file \(filePath), error=\(error.localizedDescription)")
                return
            }
        }
        
        // Check if textView has any content
        if let isEmpty = textView.text?.isEmpty, !isEmpty {
            // Write contents of textView out to file
            do {
                try textView.text?.write(toFile: filePath, atomically: true, encoding: .utf8)
            }
            catch {
                print("Could not write to file \(filePath), error=\(error.localizedDescription)")
                return
            }
        }
    }
    
    private func dismissKeyboard() {
        textView.resignFirstResponder()
    }
}
