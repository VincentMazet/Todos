//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController {
    
    var delegate : ListDetailViewControllerDelegate?
    
    var itemToEdit : CheckList?
    
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit == nil){
            //add item
            self.title = "Add List"
        }else{
            //edit item
            doneButton.isEnabled = true
            self.title = "Edit List"
            txtField.text = itemToEdit?.name
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        txtField.becomeFirstResponder()
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        delegate?.listDetailViewControllerDidCancel(controller: self)

    }

    @IBAction func done(_ sender: AnyObject) {
        if(itemToEdit == nil){
            let checkList : CheckList =  CheckList(aName: txtField.text!)
            delegate?.listDetailViewController(controller: self, didFinishAddingItem: checkList)
        } else {
            itemToEdit?.name = txtField.text!
            delegate?.editListViewController(controller: self, didFinishEdditingItem: itemToEdit!)
        }
    }
    
    @IBAction func txtFieldHasChanged(_ sender: AnyObject) {
        if(txtField.text?.isEmpty)!{
            doneButton.isEnabled = false
        }else{
            doneButton.isEnabled = true
        }
    }
}

protocol ListDetailViewControllerDelegate : class {
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingItem item: CheckList)
    
    func editListViewController(controller: ListDetailViewController, didFinishEdditingItem item: CheckList)
    
}
