//
//  ItemStore.swift
//  Homepwner3
//
//  Created by LARRY COMBS on 12/30/16.
//  Copyright © 2016 LARRY COMBS. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()

    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.insert(newItem, at: 0)
        
        return newItem
    }

    func removeItem(item: Item) {
        if let index = allItems.index(of: item){
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtItem(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
        return
        }
        //Get Reference to object being moved to you can reinsert it 
        let movedItem  = allItems[fromIndex]
        
        //Removed item from array 
        allItems.remove(at: fromIndex)
        
        //Insert item in array at new location 
        allItems.insert(movedItem, at: toIndex)
        
    }
    
    func saveChanges() -> Bool {
        print("Saving items to: \(itemArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: itemArchiveURL.path)
    }
    
    init() {
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObject(withFile: itemArchiveURL.path) as? [Item] {
            allItems = archivedItems
        }
    }
    
    
}





