//
//  TableViewController.swift
//  RealmMemoApp
//
//  Created by KumagaiNaoki on 2016/02/05.
//  Copyright © 2016年 KumagaiNaoki. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    let postCollection = PostCollection.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postCollection.fetchPosts()
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.postCollection.posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let post = self.postCollection.posts[indexPath.row]
        cell.textLabel!.text = post.postString
        return cell
    }
    
    @IBAction func pushPostButton(sender: UIBarButtonItem) {
        if textField.text!.isEmpty {
            print("テキスト空")
        } else {
            let post = Post()
            post.postString = textField.text!
            self.postCollection.addPostCollection(post)
            self.tableView.reloadData()
            textField.text = ""
        }
    }
    @IBAction func pushSearchButton(sender: UIBarButtonItem) {
        print(__FUNCTION__, __LINE__)
    }
}
