//
//  CheckListViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    var list: CheckList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = list.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let destinationNav = segue.destination as? UINavigationController
            let targetController = destinationNav?.topViewController as! ItemDetailViewController
            targetController.delegate = self
        }
        if segue.identifier == "EditItem" {
            let destinationNav = segue.destination as? UINavigationController
            let targetController = destinationNav?.topViewController as! ItemDetailViewController
            targetController.delegate = self
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            targetController.itemToEdit = list.items[(indexPath?.row)!]
        }
    }
}

extension CheckListViewController {
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        configureCell(cell: cell, withItem: list.items[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        list.items[indexPath.row].toggleChecked()
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            list.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func configureCell(cell: UITableViewCell, withItem item: CheckListItem){
        configureCheckmarkFor(cell: cell, withItem: item)
        configureTextFor(cell: cell, withItem: item)
    }
    
    func configureCheckmarkFor(cell: UITableViewCell, withItem item: CheckListItem){
        let checkLabel = self.view.viewWithTag(1) as? UILabel
        checkLabel?.isHidden = !item.checked
    }
    
    func configureTextFor(cell: UITableViewCell, withItem item: CheckListItem){
        let titleLabel = self.view.viewWithTag(2) as? UILabel
        titleLabel?.text = item.text
    }
    
}

extension CheckListViewController: ItemDetailViewControllerDelegate {
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController){
        controller.dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: CheckListItem){
        list.items.append(item)
        self.tableView.insertRows(at: [IndexPath(row: list.items.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)
        list.items = list.items
    }
    
    func editItemViewController(controller: ItemDetailViewController, didFinishEdditingItem item: CheckListItem){
        let index = list.items.index(where:{ $0 === item })
        self.tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)
        list.items = list.items
    }
}
