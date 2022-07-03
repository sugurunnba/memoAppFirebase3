//
//  AddViewController.swift
//  memoAppFirebase3
//
//  Created by 高木克 on 2022/06/26.
//

import UIKit
import Firebase


class AddViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var textText: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        let data = Firestore.firestore().collection("memos")
        data.addDocument(data: [
            "name": nameText.text!,
            "text": textText.text!
        ]) { error in
            if let error = error {
                print("ドキュメントの追加に失敗しました:", error)
            }
        }

        self.navigationController?.popViewController(animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
