//
//  CheckList.swift
//  Checklists
//
//  Created by iem on 09/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation

class CheckList : NSObject,  NSCoding {
    
    var name: String
    var items: [CheckListItem] = []
    
    init(aName: String){
        name = aName
    }
    
    init(aName: String, someItems: [CheckListItem]){
        name = aName
        items = someItems
    }
    
    // MARK: NSCoding
    required init?(coder decoder: NSCoder) {
        name = (decoder.decodeObject(forKey: "name") as? String)!
        items = (decoder.decodeObject(forKey: "items") as! [CheckListItem])
        
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.items, forKey: "items")
    }
}
