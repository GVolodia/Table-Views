//
//  EmojiTableViewController.swift
//  Table Views
//
//  Created by notwo on 3/9/22.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    // MARK: - Properties
    let cellManager = CellManager()
    var emojis = [Emoji]()
    var defaults = UserDefaults.standard
    
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
      
        // Set edit button on NavigationBar
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    func loadData() {
        // Loading data from stored in UserDefault, if any
        if let savedEmojis = defaults.object(forKey: "Emojis") as? Data {
            let decoder = JSONDecoder()
            if let decodedEmojis = try? decoder.decode([Emoji].self, from: savedEmojis) {
                emojis = decodedEmojis
            } else {
                emojis = Emoji.loadAll() ?? Emoji.loadDefault()
            }
        }
        else {
            // If there is no data stored in UserDefault, then loading data from App
            emojis = Emoji.loadDefault()
        }
    }
    
    func saveDataToUserDefaults(_ emojis: [Emoji]) {
        let encoder = JSONEncoder()
        if let encodedEmojis = try? encoder.encode(emojis) {
            
            defaults.set(encodedEmojis, forKey: "Emojis")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "EditSegue" else { return }
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        
        let emoji = emojis[selectedPath.row]
        let destination = segue.destination as! AddEditTableViewController
        destination.emoji = emoji
        destination.saveButtonState = true
    }
    
}

// MARK: - UITableViewDataSource
extension EmojiTableViewController /* UITableViewDataSource */ {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emoji = emojis[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell")! as! EmojiCell
        cellManager.configure(cell, with: emoji)
        return cell
    }
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)
        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        
        saveDataToUserDefaults(emojis)
        
        tableView.reloadData()
    }
    
    
}
// MARK: - UITableViewDelegate
extension EmojiTableViewController /* UITableViewDelegate */ {
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            emojis.remove(at: indexPath.row)
            
            saveDataToUserDefaults(emojis)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            break
        case .none:
            break
            
        @unknown default:
            print(#line, #function, "Unknown case in file \(#file)")
            break
        }
    }
}
// MARK: - Actions
extension EmojiTableViewController {
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        guard unwindSegue.identifier == "saveSegue"  else { return }
        
        let source = unwindSegue.source as! AddEditTableViewController
        let emoji = source.emoji
        
        if let selectedPath = tableView.indexPathForSelectedRow {
            // Edited cell
            emojis[selectedPath.row] = emoji
            
            saveDataToUserDefaults(emojis)
            
            //            tableView.reloadData()
            tableView.reloadRows(at: [selectedPath], with: .automatic)
        } else {
            // Added cell
            let indexPath = IndexPath(row: emojis.count, section: 0)
            emojis.append(emoji)
            
            saveDataToUserDefaults(emojis)
            
            //            tableView.reloadData()
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
}
