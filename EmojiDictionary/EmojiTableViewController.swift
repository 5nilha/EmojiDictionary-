//
//  EmojiTableViewController.swift
//  EmojiDictionary
//
//  Created by Fabio Quintanilha on 12/17/17.
//  Copyright © 2017 Fabio Quintanilha. All rights reserved.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    var emojis : [Emoji]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        //Creates a edit button on the leftBarButtonItem
         self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        //Tells the tableview that its row height should determined automatically based on the contents of the cell
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0
        
        // to load the data
        if Emoji.loadFromFile().isEmpty {
            emojis = Emoji.loadSampleEmojies()
            //Will save the emoji sample to file
            Emoji.saveToFile(emojies: emojis)
        }
        else {
            emojis = Emoji.loadFromFile()
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if section == 0 {
            return emojis.count
        }
        else {
            return 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Step 1: Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        
        //Step 2: fetch model object to display
        let emoji = emojis[indexPath.row]
        
        //Step 3: Configure cell
        cell.update(with: emoji)
            
        //Reorder Cells
        cell.showsReorderControl = true
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let emoji = emojis[indexPath.row]
        
//        performSegue(withIdentifier: "goToEmojiVC", sender: self)
         
          performSegue(withIdentifier: "EditEmoji", sender: self)
    }
    
    
    
    @objc func detailClicked() {
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
    
    
    //Preparing to segue to another view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "EditEmoji" {
           
            if let destinationVC = segue.destination as? EditEmojiTableViewController {
                let indexPath = tableView.indexPathForSelectedRow!
                let emoji = emojis[indexPath.row]
                destinationVC.emoji = emoji
                print(emoji.name)
            }
        }
        else if (segue.identifier == "DetailSegue") {
            
            if let destination = segue.destination as? EmojiProfileViewController {
                let row = tableView.indexPathForSelectedRow!.row
                destination.emoji = emojis[row]
            }
        }
        
    }


    
    @IBAction func AddEmoji(_ sender: Any) {
        
         performSegue(withIdentifier: "addEmoji", sender: self)
    }
    
    
    //To dismiss the AddEditEmojiTableVC
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        
        //checks if the optinal segue identifier is equal to the segue Unwind
        guard segue.identifier == "saveUnwind" else { return }
        
        let sourceViewController = segue.source as! EditEmojiTableViewController
        
        if let emoji = sourceViewController.emoji {
            
            //updating the edited emoji
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                emojis[selectedIndexPath.row] = emoji
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            //adding new emoji
            else {
                let newIndexPath = IndexPath(row: emojis.count, section: 0)
                emojis.append(emoji)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
           
            Emoji.saveToFile(emojies: emojis)
            
        }
        
    }
    
    
    //Reordering the cells function
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        
        tableView.reloadData()
    }
    
    
    //Deleting an emoji
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }

}
