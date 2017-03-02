//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 09/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var dataModel : DataModel = DataModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showItems" {
            let targetController = segue.destination as? CheckListViewController
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            targetController?.list = dataModel.lists[(indexPath?.row)!]
        }
        if segue.identifier == "AddList" {
            let destinationNav = segue.destination as? UINavigationController
            let targetController = destinationNav?.topViewController as! ListDetailViewController
            targetController.delegate = self
        }
        if segue.identifier == "EditList" {
            let destinationNav = segue.destination as? UINavigationController
            let targetController = destinationNav?.topViewController as! ListDetailViewController
            targetController.delegate = self
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            targetController.itemToEdit = dataModel.lists[(indexPath?.row)!]
        }
    }
}

extension AllListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  dataModel.lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Checklist", for: indexPath)
        let checkList = dataModel.lists[indexPath.item]
        cell.textLabel?.text = checkList.name
        cell.detailTextLabel?.text = String(checkList.uncheckedItemCounts)
        if checkList.uncheckedItemCounts == 0 {
            cell.detailTextLabel?.text = "All Done !"
            if checkList.items.count == 0{
                cell.detailTextLabel?.text = "(No Item)"
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
}

extension AllListViewController: ListDetailViewControllerDelegate
{
    func listDetailViewControllerDidCancel(controller: ListDetailViewController){
        controller.dismiss(animated: true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingItem item: CheckList){
        dataModel.lists.append(item)
        self.tableView.insertRows(at: [IndexPath(row: dataModel.lists.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)

    }
    
    func editListViewController(controller: ListDetailViewController, didFinishEdditingItem item: CheckList){
        let index = dataModel.lists.index(where:{ $0 === item })
        self.tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)

    }
}
