//
//  BooksViewController.swift
//  BookList
//
//  Created by Dan Esrey on 2016/24/09.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit

class BooksViewController: UITableViewController {
   
    var books: [Book] = []
    var bookStore: BookStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
        bookStore.fetchBooks{
            (booksResult) -> Void in
            switch booksResult {
            case let .success(books):
                print("Successfully found \(books.count) books.")
                OperationQueue.main.addOperation {
                    self.books = books
                    self.tableView.reloadData()
                }
                
            case let .failure(error):
                print("Error fetching recent photos: \(error)")

            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let book = books[(indexPath as NSIndexPath).row]
        cell.title.text = book.title
        cell.author.text = book.author
        return cell
    }
}
