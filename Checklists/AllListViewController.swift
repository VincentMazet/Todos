//
//  AllListViewController.swift
//  Checklists
//
//  Created by iem on 09/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AllListViewController: UITableViewController {
    
    var lists : [CheckList] = []
    
    override func viewDidLoad() {
        lists.append(CheckList(aName: "list 1"))
        lists.append(CheckList(aName: "list 2"))
        lists.append(CheckList(aName: "list 3"))

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
            targetController?.list = lists[(indexPath?.row)!]
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
            targetController.itemToEdit = lists[(indexPath?.row)!]
        }
    }
}

extension AllListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Checklist", for: indexPath)
        cell.textLabel?.text = lists[indexPath.item].name
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
        lists.append(item)
        self.tableView.insertRows(at: [IndexPath(row: lists.count - 1, section: 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editListViewController(controller: ListDetailViewController, didFinishEdditingItem item: CheckList){
        let index = lists.index(where:{ $0 === item })
        self.tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableViewRowAnimation.automatic)
        controller.dismiss(animated: true, completion: nil)
    }
}
