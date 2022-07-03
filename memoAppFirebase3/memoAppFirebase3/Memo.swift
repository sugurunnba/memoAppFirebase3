//
//  Memo.swift
//  memoAppFirebase3
//
//  Created by 高木克 on 2022/06/26.
//

import UIKit
import Firebase

struct Memo {
    var name: String = ""
    var text: String = ""
    var documentId: String = ""
    
    init(dic: [String: Any], documentId: String){
         self.name = dic["name"] as! String
         self.text = dic["text"] as! String
         self.documentId = documentId
    }
}
    
//    mutating func setFromDictionary(_ dictionary: [String: Any]) {
//        name = dictionary["name"] as? String ?? ""
//        text = dictionary["text"] as? String ?? ""
//    }
//
//    var toDictionary: [String: Any] {
//        return [
//            "name": name,
//            "text": text
//        ]
//    }

