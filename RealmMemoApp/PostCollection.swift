//
//  PostCollection.swift
//  RealmMemoApp
//
//  Created by KumagaiNaoki on 2016/02/05.
//  Copyright © 2016年 KumagaiNaoki. All rights reserved.
//

import UIKit
import RealmSwift

class PostCollection: NSObject {
    
    static let sharedInstance = PostCollection()
    var post:Post?
    var posts:[Post] = []
    var resultsArray:[Post] = []
    let realm = try!Realm()
    
    func addPostCollection(post: Post){
        self.post = post
        self.save()
    }
    
    func save () {
        try! realm.write({ () -> Void in
            realm.add(self.post!)
            self.posts.insert(self.post!, atIndex: 0)
        })
    }
    
    func fetchPosts(){
        let allPost = realm.objects(Post)
        for onePost in allPost {
            let post = Post()
            post.postString = onePost["postString"] as! String
            self.posts.insert(onePost, atIndex: 0)
        }
    }
    
    func searchPosts(searchText:String) {
        let results = realm.objects(Post).filter("postString CONTAINS '\(searchText)'")
        for result in results {
            let post = Post()
            post.postString = result["postString"] as! String
            resultsArray.insert(post, atIndex: 0)
        }
    }
    
}