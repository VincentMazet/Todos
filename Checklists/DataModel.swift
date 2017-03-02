//
//  DataModel.swift
//  Checklists
//
//  Created by iem on 02/03/2017.
//  Copyright © 2017 iem. All rights reserved.
//
import UIKit


class DataModel{
    
    static let sharedInstance = DataModel()
    public var lists : [CheckList] = []

    private init() {
        loadChecklists()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DataModel.saveChecklists),
            name: .UIApplicationDidEnterBackground,
            object: nil)
        
    }
    
    func sortChecklists() {
        lists = lists.sorted(by: { checklist1, checklist2 in return
            checklist1.name.localizedStandardCompare(checklist2.name) == ComparisonResult.orderedAscending })
    }
    
    func documentDirectory() -> URL{
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func dataFileUrl() -> URL{
        let docsDir : URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docsDir.appendingPathComponent("Ckecklists.plist")
    }
    
    @objc func saveChecklists(){
        NSKeyedArchiver.archiveRootObject(lists, toFile: dataFileUrl().path)
    }
    
    func loadChecklists(){
        if(NSKeyedUnarchiver.unarchiveObject(withFile: dataFileUrl().path) != nil){
            lists = NSKeyedUnarchiver.unarchiveObject(withFile: dataFileUrl().path) as! [CheckList]
        }
    }
}
