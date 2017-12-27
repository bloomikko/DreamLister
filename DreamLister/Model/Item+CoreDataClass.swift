//
//  Item+CoreDataClass.swift
//  DreamLister
//  Copyright © 2017 Mikko Rouru. All rights reserved.
//

import Foundation
import CoreData

public class Item: NSManagedObject {

    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
}
