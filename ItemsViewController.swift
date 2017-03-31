//
//  ItemsViewController.swift
//  Homepwner3
//
//  Created by LARRY COMBS on 12/29/16.
//  Copyright © 2016 LARRY COMBS. All rights reserved.
//


import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    var imageStore: ImageStore!
    
    @IBAction func addNewItem(sender: UIBarButtonItem){
      //Create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // Figure out where that item is in the array 
        if let index = itemStore.allItems.index(of: newItem) {
            let indexPath = IndexPath(row: index, section: 0)
        
        //Insert this new row into the table 
        tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
   
   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
   
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a new or recycled cell 
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        // Set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear in on the tableview 
        let item = itemStore.allItems[indexPath.row]
        
        //Configure the cell with the Item
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // If the table view is acking to comit a delet command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController (title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive, handler: {(action) -> Void in
            
            //Remove the item from the store 
            self.itemStore.removeItem(item: item)
                
            //Remove the item's image fromthe image store
            self.imageStore.deletImage(forKey: item.itemKey)
            
            //Also remove that row fromthe table view with an animation 
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        })
        ac.addAction(deleteAction)
        
        //Present the alert controller
        present(ac, animated: true, completion: nil)
        
        }
    }
    
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //Updated the model
        itemStore.moveItemAtItem(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If the trigger segue is the "showItem" segue 
        switch segue.identifier {
        case "showItem"?:
            //Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
            
            // Get the item associated with this row and pass it along
            let item = itemStore.allItems [row]
            let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                detailViewController.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected Segue Indentifier.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
}










