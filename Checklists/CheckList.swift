//
//  CheckList.swift
//  Checklists
//
//  Created by iem on 09/02/2017.
//  Copyright © 2017 iem. All rights reserved.
//

import Foundation

class CheckList : NSObject {
    
    var name: String
    var items: [CheckListItem] = []
    
    init(aName: String){
        name = aName
    }
    
    init(aName: String, someItems: [CheckListItem]){
        name = aName
        items = someItems
    }

}
