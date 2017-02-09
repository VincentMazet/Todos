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
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: AnyObject) {
        delegate?.addItemViewControllerDidCancel(controller: self)
    }
    @IBAction func done(_ sender: AnyObject) {
        let checkListItem : CheckListItem =  CheckListItem(aText: txtField.text!)
        delegate?.addItemViewController(controller: self, didFinishAddingItem: checkListItem)
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
    
}
