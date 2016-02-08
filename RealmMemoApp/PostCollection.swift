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
    
    func addPostCollection(post: Post){
        self.post = post
        self.save()
    }
    
    func save () {
        let realm = try!Realm()
        try! realm.write({ () -> Void in
            realm.add(self.post!)
            self.posts.append(self.post!)
        })
    }
    
    func fetchPosts(){
        let realm = try!Realm()
        let allPost = realm.objects(Post)
        for post in allPost {
            let convertPost = PostCollection.convertPostModel(post)
            self.posts.append(convertPost)
        }
    }
    class func convertPostModel(attributes: Post) -> Post {
        let post = Post()
        post.postString = attributes["postString"] as! String
        return post
    }
    
    func searchPosts(searchText:String) {
        let realm = try!Realm()
        let results = realm.objects(Post).filter("postString CONTAINS '\(searchText)'")
        for result in results {
            let post = Post()
            post.postString = result["postString"] as! String
            resultsArray.append(post)
        }
    }
    
    
}