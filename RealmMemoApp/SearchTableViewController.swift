//
//  SearchTableViewController.swift
//  RealmMemoApp
//
//  Created by KumagaiNaoki on 2016/02/06.
//  Copyright © 2016年 KumagaiNaoki. All rights reserved.
//

import UIKit
import RealmSwift

class SearchTableViewController: UITableViewController {
    
    var searchText:String = ""
    let postCollection = PostCollection()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postCollection.searchPosts(searchText)
    }

  
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postCollection.resultsArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let post = postCollection.resultsArray[indexPath.row]
        cell.textLabel?.text = post.postString  
        return cell
    }
    
    @IBAction func pushStopButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
