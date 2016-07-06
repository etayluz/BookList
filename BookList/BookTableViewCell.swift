//
//  BookTableViewCell.swift
//  BookList
//
//  Created by Etay Luz on 7/5/16.
//  Copyright © 2016 Etay Luz. All rights reserved.
//

import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
  
  @IBOutlet weak var bookTitleLabel: UILabel!
  @IBOutlet weak var bookAuthorLabel: UILabel!
  @IBOutlet weak var bookImageView: UIImageView!
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    bookTitleLabel.text = nil
    bookAuthorLabel.text = nil
    bookImageView.image = nil
  }
  
  func configureCellWithBook(book:Book) {
    
    if let bookTitle = book.title {
      self.bookTitleLabel.text = bookTitle
    }
    if let bookAuthor = book.author {
      self.bookAuthorLabel.text = bookAuthor
    }
    if let bookImageUrl = book.imageUrl {
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        let data = NSData(contentsOfURL:  NSURL(string: bookImageUrl)!)
        if let data = data {
          dispatch_async(dispatch_get_main_queue(), {
            self.bookImageView.image = UIImage(data: data)
          })
        }
      }
    }
  }
  
}