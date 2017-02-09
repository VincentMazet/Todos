//
//  CheckListViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    var checkListItems : [CheckListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mock1 : CheckListItem = CheckListItem(aText: "mock item 1")
        let mock2 : CheckListItem = CheckListItem(aText: "mock item 2", isChecked: true)
        let mock3 : CheckListItem = CheckListItem(aText: "mock item 3", isChecked: true)
        let mock4 : CheckListItem = CheckListItem(aText: "mock item 4", isChecked: false)

        checkListItems.append(mock1)
        checkListItems.append(mock2)
        checkListItems.append(mock3)
        checkListItems.append(mock4)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CheckListViewController {
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureCell(cell: cell, withItem: checkListItems[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        checkListItems[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            checkListItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func configureCell(cell: UITableViewCell, withItem item: CheckListItem){
        configureCheckmarkFor(cell: cell, withItem: item);
        configureTextFor(cell: cell, withItem: item)
    }
    
    func configureCheckmarkFor(cell: UITableViewCell, withItem item: CheckListItem){
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureTextFor(cell: UITableViewCell, withItem item: CheckListItem){
        cell.textLabel?.text = item.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let destinationNav = segue.destination as? UINavigationController
            let targetController = destinationNav?.topViewController as! AddItemViewController
            targetController.delegate = self
        }
    }
    
}

extension CheckListViewController: AddItemViewControllerDelegate{
    
    func addItemViewControllerDidCancel(controller: AddItemViewController){
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: CheckListItem){
        checkListItems.append(item)
        self.tableView.insertRows(at: [IndexPath(row: checkListItems.count - 1, section: 0)
            ], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)
    }
}
