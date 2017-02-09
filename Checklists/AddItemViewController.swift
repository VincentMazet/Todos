//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    var delegate : AddItemViewControllerDelegate?
    
    var itemToEdit : CheckListItem?
    
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit == nil){
            //add item
            self.title = "Add Item"
        }else{
            //edit item
            self.title = "Edit Item"
            txtField.text = itemToEdit?.text
        }
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        delegate?.addItemViewControllerDidCancel(controller: self)
    }
    @IBAction func done(_ sender: AnyObject) {
        if(itemToEdit == nil){
            let checkListItem : CheckListItem =  CheckListItem(aText: txtField.text!)
            delegate?.addItemViewController(controller: self, didFinishAddingItem: checkListItem)
        } else {
            itemToEdit?.text = txtField.text!
            delegate?.editItemViewController(controller: self, didFinishEdditingItem: itemToEdit!)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        txtField.becomeFirstResponder()
    }
    @IBAction func txtFieldHasChanged(_ sender: AnyObject) {
        if(txtField.text?.isEmpty)!{
            doneButton.isEnabled = false;
        }else{
            doneButton.isEnabled = true;
        }
    }
}

protocol AddItemViewControllerDelegate : class {
    
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: CheckListItem)
    
    func editItemViewController(controller: AddItemViewController, didFinishEdditingItem item: CheckListItem)
    
}
