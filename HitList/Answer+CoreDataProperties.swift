//
//  Answer+CoreDataProperties.swift
//  HitList
//
//  Created by Kacper Augustyniak on 18/06/16.
//  Copyright © 2016 Kacper Augustyniak. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Answer {

    @NSManaged var isCorrect: NSNumber?
    @NSManaged var text: String?
    @NSManaged var aQRelation: Question?

}
