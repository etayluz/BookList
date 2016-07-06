//
//  BookViewController.swift
//  BookList
//
//  Created by Etay Luz on 7/5/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import UIKit

let stringUrl = "http://de-coding-test.s3.amazonaws.com/books.json"

class BookViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  @IBOutlet weak var tableView: UITableView!
  var bookList = [Book]()
  
  override func viewDidLoad() {
    super.viewDidLoad()

    getBookList()
  }

  /**
   Asynchroneously fetch json from remote URL and parse manually.
   Store in Book model object
   Append Book object to BookList array
   Finally, refresh table view with fresh data.
   
   TBD: API Manager and Service layer for separation of concerns and avoidance of a "Massive View Controller"
   TBD: Incorporate AlamoFire for chainable resopnse methods and JSON response serialization
   TBD; Incorporate SwiftyJson for parsing and serializing JSON
   
   - parameter data: none
   */
  func getBookList() {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
      let jsonData = NSData(contentsOfURL: NSURL(string: stringUrl)!)

      do {
        let list = try NSJSONSerialization.JSONObjectWithData(jsonData!, options:NSJSONReadingOptions.MutableContainers ) as? [AnyObject]

        for item in list! {
          var bookTitle = ""
          var bookImageUrl = ""
          var bookAuthor = ""
          
          if let title = item["title"] as? String {
            bookTitle = title
          }
          if let imageUrl = item["imageURL"] as? String {
            bookImageUrl = imageUrl
          }
          if let author = item["author"] as? String {
            bookAuthor = author
          }
          self.bookList.append(Book(title: bookTitle, imageUrl: bookImageUrl, author: bookAuthor))
          
        }
        
        dispatch_async(dispatch_get_main_queue(), {
          self.tableView.reloadData()
        })

      } catch {
        print("Invalid Json")
      }
    }
    

  }

  // MARK: UITableView delegate
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
    return bookList.count
  }
  
  func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 0.0
  }
  
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
  {
    return 60.0
  }
  
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier("BookTableViewCell", forIndexPath: indexPath) as! BookTableViewCell
    cell.configureCellWithBook(bookList[indexPath.section])
    
    return cell
  }
}

