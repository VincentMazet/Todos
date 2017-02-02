//
//  CheckListItem.swift
//  Checklists
//
//  Created by iem on 02/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation

class CheckListItem{
    
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
}
