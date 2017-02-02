//
//  AddItemViewController.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {

    
    @IBOutlet weak var txtField: UITextField!
    
    @IBAction func cancel(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func done(_ sender: AnyObject) {
        print(txtField.text)
        dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        txtField.becomeFirstResponder()
    }
}
