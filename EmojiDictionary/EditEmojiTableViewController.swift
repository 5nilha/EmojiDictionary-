//
//  EditEmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Fabio Quintanilha on 12/18/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//

import UIKit

class EditEmojiTableViewController: UITableViewController {

     var emoji : Emoji?
    
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let emoji = emoji {
            print(emoji.name)
                        symbolTextField.text = emoji.symbol
                        nameTextField.text = emoji.name
                        descriptionTextField.text = emoji.description
                        usageTextField.text = emoji.usage
        }
        else{
            print("empty emoji")
        }
        
        updateSaveButtonState()
        
    }

 
    //The save button should only be enabled if every textfield contains a value
    func updateSaveButtonState() {
        
        //check if the textFields have data. If not, assign "", if have, assign the data to each related constant
        let symbolText = symbolTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let usageText = usageTextField.text ?? ""
        
        //Check if the textfields are empty
        if !(symbolText.isEmpty) && !(nameText.isEmpty) && !(descriptionText.isEmpty) && !usageText.isEmpty {
            
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }

    
    //Each text field is connected to this method to observe if the text changed
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        //Only will prepare and handle the data if the save button is clicked. If the cancel button is clicked no data in handled
        guard segue.identifier == "saveUnwind"
            else {
                return
        }
        
        //Since the save button handles to do not allow empty data, we just add the data to its constants. the values will never be empty
        let symbol = symbolTextField.text!
        let name = nameTextField.text!
        let description = descriptionTextField.text!
        let usage = usageTextField.text!
        
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
        
        
    }


}
