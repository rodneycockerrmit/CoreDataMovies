//
//  Movie+CoreDataProperties.swift
//  CoreDataMovies
//
//  Created by Rodney Cocker on 6/7/18.
//  Copyright © 2018 RMIT. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var movieName: String?
    @NSManaged public var movieDescription: String?
    @NSManaged public var movieImageName: String?

}
