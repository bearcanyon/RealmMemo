//
//  TableViewController.swift
//  RealmMemoApp
//
//  Created by KumagaiNaoki on 2016/02/05.
//  Copyright © 2016年 KumagaiNaoki. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController{

    @IBOutlet weak var textField: UITextField!
    let postCollection = PostCollection.sharedInstance
    let backgroundView = UIView()
    let modal = UIView()
    let modalTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeTap()
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
        textField.resignFirstResponder()
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
    
    func makeTap(){
        let tapRecogniser = UITapGestureRecognizer(target: self, action: "tap:")
        self.view.addGestureRecognizer(tapRecogniser)
    }
    func tap(sender:UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
//MARK: -MakeView
    @IBAction func pushSearchButton(sender: UIBarButtonItem) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        makeSearchView()
    }
    func makeSearchView() {

        backgroundView.frame = self.view.bounds
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        modal.frame = CGRectMake((self.view.frame.width - 300) / 2, 100, 300, 200)
        modal.backgroundColor = UIColor.whiteColor()
        
        modalTextField.frame.origin = CGPoint(x: 10, y: 10)
        modalTextField.frame.size = CGSize(width: 280, height: 40)
        modalTextField.backgroundColor = UIColor(red: 203/255, green: 73/255, blue: 62/255, alpha: 0.8)
        modalTextField.placeholder = "入力してください"

        let searchButton = UIButton(frame: CGRectMake(150, modal.frame.height - 50, 150, 40))
        searchButton.setTitle("検索", forState: UIControlState.Normal)
        searchButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        searchButton.addTarget(self, action: "search", forControlEvents: UIControlEvents.TouchUpInside)

        let CancelButton = UIButton(frame: CGRectMake(0, modal.frame.height - 50, 150, 40))
        CancelButton.setTitle("キャンセル", forState: UIControlState.Normal)
        CancelButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        CancelButton.addTarget(self, action: "cancel", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(backgroundView)
        self.view.addSubview(modal)
        modal.addSubview(modalTextField)
        modal.addSubview(searchButton)
        modal.addSubview(CancelButton)
    }
    func search() {
        if modalTextField.text!.isEmpty {
            print("テキスト空")
        } else {
            self.performSegueWithIdentifier("SearchViewModalSegue", sender: self)
            backgroundView.removeFromSuperview()
            modal.removeFromSuperview()
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navigationController = segue.destinationViewController as! UINavigationController
        let correntViewController = navigationController.topViewController as! SearchTableViewController
        correntViewController.searchText = modalTextField.text!
        modalTextField.text = ""
    }
    
    func cancel() {
        backgroundView.removeFromSuperview()
        modal.removeFromSuperview()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
