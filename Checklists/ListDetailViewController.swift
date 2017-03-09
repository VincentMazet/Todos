//
//  ListDetailViewController.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class ListDetailViewController: UITableViewController{
    
    var delegate : ListDetailViewControllerDelegate?
    
    var itemToEdit : CheckList?
    
    
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var textIcon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(itemToEdit == nil){
            //add item
            self.title = "Add List"
            textIcon.text = "Folder"
            imageIcon.image = UIImage(named: "Folder")
        }else{
            //edit item
            doneButton.isEnabled = true
            self.title = "Edit List"
            txtField.text = itemToEdit?.name
            textIcon.text = itemToEdit?.icon
            imageIcon.image = UIImage(named: (itemToEdit?.icon)!)
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
            checkList.icon = textIcon.text!
            delegate?.listDetailViewController(controller: self, didFinishAddingItem: checkList)
        } else {
            itemToEdit?.name = txtField.text!
            itemToEdit?.icon = textIcon.text!
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
    
    @IBAction func finished(_ sender: AnyObject) {
        self.view.endEditing(true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectIcon" {
            let destinationNav = segue.destination as? UINavigationController
            let targetController = destinationNav?.topViewController as! IconPickerViewController
            targetController.delegate = self
        }
    }
}

extension ListDetailViewController: IconPickerViewControllerDelegate{
    
    func IconPickerViewControllerDidCancel(controller : IconPickerViewController){
        controller.dismiss(animated: true, completion: nil)
    }

    
    func IconPickerViewControllerDidSelect(controller: IconPickerViewController, imageName: String){
        self.textIcon.text = imageName
        self.imageIcon.image = UIImage(named: imageName)
        controller.dismiss(animated: true, completion: nil)
    }
    
}

protocol ListDetailViewControllerDelegate : class {
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController)
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingItem item: CheckList)
    
    func editListViewController(controller: ListDetailViewController, didFinishEdditingItem item: CheckList)
    
}
