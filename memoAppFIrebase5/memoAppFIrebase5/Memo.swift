//
//  Memo.swift
//  memoAppFIrebase5
//
//  Created by 高木克 on 2022/07/02.
//

import Foundation
import Firebase

struct Memo {
    var name: String = ""
    var text: String = ""
    
    init(dic: [String: Any]){
         self.name = dic["name"] as! String
         self.text = dic["text"] as! String
    }
}
    
