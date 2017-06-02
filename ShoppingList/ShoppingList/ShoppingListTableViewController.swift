//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Bradley GIlmore on 6/2/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, ItemTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = ItemController.shared.fetchTasks().count
        return sections
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else { return UITableViewCell() }
        
        let item = ItemController.shared.fetchTasks()[indexPath.row] // Don't think this is going to work
        cell.delegate = self
        cell.item = item

        

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let item = ItemController.shared.items[indexPath.row]
            ItemController.shared.deleteItem(item: item)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
        }    
    }
    

    @IBAction func addButtonTapped(_ sender: Any) {
        
        var alertTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add Item", message: "Please add an item to your shopping list", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            alertTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertTextField?.text, !text.isEmpty else { return }
            ItemController.shared.createNewItemWith(name: text)
            self.tableView.reloadData()
        }
        // ^^Creates the new item from the text we put in the textfield
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }

    
    //MARK: - ItemTableViewCellDelegate Functions
    
    func cellButtonTapped(sender: ItemTableViewCell) {
        
        guard let newIndexPath = tableView.indexPath(for: sender) else  { return }
        let item = ItemController.shared.items[newIndexPath.row]
        ItemController.shared.toggleIsCompleteFor(item: item)
        tableView.reloadRows(at: [newIndexPath], with: .automatic)
        
    }
    
}
