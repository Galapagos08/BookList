//
//  BookStore.swift
//  BookList
//
//  Created by Dan Esrey on 2016/24/09.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import UIKit
import CoreData

class BookStore {
    
    let coreDataStack = CoreDataStack(modelName: "BookList")
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func processRecentBooksRequest (data: Data?, error: NSError?) -> BooksResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        return EbayAPI.booksFromJSONData(jsonData, inContext: self.coreDataStack.mainQueueContext)
    }
    
    func fetchBooks(completion: @escaping (BooksResult) -> Void ) {
        let url = EbayAPI.url
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            let result = self.processRecentBooksRequest(data: data, error: error as NSError?)
            completion(result)
        })
        task.resume()
    }
    
}
