//
//  API.swift
//  BookList
//
//  Created by Dan Esrey on 2016/24/09.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation

let session = URLSession(configuration: URLSessionConfiguration.default)

let request = URLRequest(url: NSURL(string: "http://de-coding-test.s3.amazonaws.com/books.json")! as URL)

let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) -> Void in
    if let data = data {
        let response = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        print(response)
    }
}

