//
//  AddEditTableViewController.swift
//  Table Views
//
//  Created by notwo on 3/9/22.
//

import UIKit

class AddEditTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    // MARK: - Properties
    
    var emoji = Emoji()
    var saveButtonState: Bool = false
    
    
    // MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = saveButtonState
        updateUI()
    }
    
    // MARK: - Methods
    func updateUI() {
        symbolTextField.text = emoji.symbol
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description
        usageTextField.text = emoji.usage
    }
    
    func saveEmoji() {
        emoji.symbol = symbolTextField.text ?? ""
        emoji.name = nameTextField.text ?? ""
        emoji.description = descriptionTextField.text ?? ""
        emoji.usage = usageTextField.text ?? ""
    }
    
    func changeSaveButtonState() {
        
        // Check if all text fields are not empty and symbol text field has only 1 character and it IS an emoji
        // if so, then make save button enabled
        if nameTextField.text != "", descriptionTextField.text != "", usageTextField.text != "" {
            guard let char = symbolTextField.text else { saveButton.isEnabled = false; return }
            guard char.count == 1 else { saveButton.isEnabled = false; return }
            guard char.unicodeScalars.first!.properties.isEmoji else { saveButton.isEnabled = false; return }
            saveButton.isEnabled = true
        } else {
            
            saveButton.isEnabled = false
        }
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        saveEmoji()
    }
    
    // MARK: - Actions
    
    @IBAction func textFieldChanged(_ sender: UITextField) {
        // While editing text fields - is constantly checking if save button can be made enabled
        changeSaveButtonState()
    }
    
}
