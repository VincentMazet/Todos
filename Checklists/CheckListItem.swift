//
//  CheckListItem.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation

class CheckListItem : NSObject, NSCoding {
    
    var text: String
    var checked: Bool = false
    
    init(aText: String, isChecked: Bool){
        text = aText
        checked = isChecked
    }
    
    init(aText: String){
        text = aText
    }
    
    func toggleChecked(){
        if checked{
            checked = false
        }else{
            checked = true
        }
    }
    
    // MARK: NSCoding
    required init?(coder decoder: NSCoder) {
         text = (decoder.decodeObject(forKey: "text") as? String)!
         checked = (decoder.decodeBool(forKey: "checked"))
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(self.text, forKey: "text")
        aCoder.encode(self.checked, forKey: "checked")
    }
}
