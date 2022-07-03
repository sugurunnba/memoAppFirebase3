//
//  RootTableViewController.swift
//  memoAppFirebase3
//
//  Created by 高木克 on 2022/06/26.
//

import UIKit
import Firebase

class RootTableViewController: UITableViewController {
    
    var memos: [Memo]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("成功")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        memos = []
        
//        データベースへの参照を定義
        let data = Firestore.firestore()
        data.collection("memos").getDocuments { [self] (snap, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            } else {
                for document in snap!.documents {
                    let data = document.data()
                    print(data["name"]!)
                    let memo = Memo.init(dic: data)
    //                メモの配列に追加
                    self.memos.append(memo)
                }
            }
            self.tableView.reloadData()
        }
        
//        data.child("memos").observe(.value) { (snapshot) in
////            初期化
//            self.memos = []
//
//            for data in snapshot.children {
//                let snapData = data as! DataSnapshot
//                let dictionarySnapData = snapData.value as! [String: Any]
//
//                var memo = Memo()
//                memo.setFromDictionary(dictionarySnapData)
//
////                メモの配列に追加
//                self.memos.append(memo)
//            }
//
//            self.memosTableView.reloadData()
        
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Add", bundle: nil)
        let AddVC = storyboard.instantiateViewController(withIdentifier: "addNavigationController") as! UINavigationController
        let view = AddVC.topViewController as! AddViewController
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _memos = memos else { return 0 }
        return _memos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootTableViewCell", for: indexPath)
        let memo = memos[indexPath.row]
        
        let nameLabel = cell.viewWithTag(1) as! UILabel
        nameLabel.text = memo.name
        
        let textLabel = cell.viewWithTag(2) as! UILabel
        textLabel.text = memo.text
        
        return cell
    }
    
//    セルタップ時
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memos.remove(at: indexPath.row)
//            Firestore.firestore().collection("memos").document(memos[indexPath.row].documentID).delete()
            Firestore.firestore().collection("memos").document("ここのIDの取得方法を教えていただけませんか？").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
