//
//  IconPickerViewController.swift
//  Checklists
//
//  Created by iem on 09/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import UIKit

class IconPickerViewController: UITableViewController {
    
    static let icons = [
        "Appointments",
        "Birthdays",
        "Chores",
        "Drinks",
        "Folder",
        "Groceries",
        "Inbox",
        "No Icon",
        "Photos",
        "Trips"]
    
    var delegate : IconPickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancel(_ sender: AnyObject) {
        delegate?.IconPickerViewControllerDidCancel(controller: self)
    }
    
}

extension IconPickerViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return IconPickerViewController.icons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IconCell", for: indexPath)
        cell.imageView?.image = UIImage(named: IconPickerViewController.icons[indexPath.item])
        cell.textLabel?.text = IconPickerViewController.icons[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             delegate?.IconPickerViewControllerDidSelect(controller: self, imageName: IconPickerViewController.icons[indexPath.item])
    }
}

protocol IconPickerViewControllerDelegate : class {
    
    func IconPickerViewControllerDidCancel(controller : IconPickerViewController)
     
    func IconPickerViewControllerDidSelect(controller: IconPickerViewController, imageName: String)
}
