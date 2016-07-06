//
//  Book.swift
//  BookList
//
//  Created by Etay Luz on 7/5/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation

class Book:NSObject {
  
  var title: String?
  var imageUrl: String?
  var author: String?
  
  init(title:String?,imageUrl:String?,author:String?){
    
    self.title = title
    self.imageUrl = imageUrl
    self.author = author
    
  }
  
}