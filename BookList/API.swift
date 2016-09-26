//
//  API.swift
//  BookList
//
//  Created by Dan Esrey on 2016/24/09.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation
import CoreData

enum BooksResult {
    case success ([Book])
    case failure (Error)
}

enum EbayError: Error {
    case invalidjsonData
}

class EbayAPI {
    
    
    static internal let url = URL(string:"https://de-coding-test.s3.amazonaws.com/books.json")!
    
    class func booksFromJSONData (_ data: Data, inContext context: NSManagedObjectContext)-> BooksResult {
        
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let booksArray = jsonObject as? [[String:AnyObject]] else {
                    return .failure(EbayError.invalidjsonData)
            }
            
            var finalBooks = [Book]()
            for bookJSON in booksArray {
                if let book = bookFromJSONObject(bookJSON, inContext: context) {
                    finalBooks.append(book)
                }
            }
            
            if finalBooks.count == 0 && booksArray.isEmpty == false {
                return .failure(EbayError.invalidjsonData)
            }
            return .success(finalBooks)
        }
        catch let error {
            return .failure(error)
        }
        
    }
    
    fileprivate class func bookFromJSONObject (_ json: [String:AnyObject], inContext context: NSManagedObjectContext)-> Book? {
        guard let
             title = json["title"] as? String else {
                return nil
        }
        let author = json["author"] as? String
        let imageURL = json["imageURL"] as? String
        
        var book:Book!
        context.performAndWait({ () -> Void in
            if #available (iOS 10.0, *) {
                book = Book(entity: Book.entity(),
                            insertInto: context)
            } else{
                book = NSEntityDescription.insertNewObject(forEntityName: "Book", into: context) as! Book}
            book.title = title
            book.author = author
            book.imageURL = imageURL
            book.thumbnailKey = imageURL.map { _ in UUID().uuidString }
            })
        
        return book
    }
}
