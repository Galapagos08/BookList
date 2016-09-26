//
//  Book+CoreDataProperties.swift
//  BookList
//
//  Created by Dan Esrey on 2016/26/09.
//  Copyright © 2016 Dan Esrey. All rights reserved.
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book");
    }

    @NSManaged public var author: String?
    @NSManaged public var image: NSObject?
    @NSManaged public var imageURL: String?
    @NSManaged public var title: String?
    @NSManaged public var thumbnailKey: String?

}
