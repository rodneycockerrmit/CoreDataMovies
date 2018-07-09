//
//  Model.swift
//  CoreDataMovies
//
//  Created by Rodney Cocker on 6/7/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class Model
{
    static let sharedInstance = Model()
    
    var movieDb = [Movie]()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext: NSManagedObjectContext
    
    private init()
    {
        managedContext = appDelegate.persistentContainer.viewContext
        getMoviesFromCoreData()
    }
    
    func updateDatabase()
    {
        do{
            try managedContext.save()
        }catch let error as NSError
        {
           print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deleteMovie(_ indexPath: IndexPath)
    {
        let movie = movieDb[indexPath.item]
        movieDb.remove(at: indexPath.item)
        managedContext.delete(movie)
        updateDatabase()
    }
    
    func getMoviesFromCoreData()
    {
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
            
            let results = try managedContext.fetch(fetchRequest)
            movieDb = results as! [Movie]
        }
        catch let error as NSError
        {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func saveMovie(movie_name: String, movie_desc: String, imageName: String, existing: Movie?)
    {
        let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedContext)
        
        if let _ = existing
        {
            existing!.movieName = movie_name
            existing!.movieDescription = movie_desc
            existing!.movieImageName = imageName
        }
        else
        {
            let movie =  NSManagedObject(entity: entity!, insertInto: managedContext) as! Movie
            movie.setValue(movie_name, forKey: "movieName")
            movie.setValue(movie_desc, forKey: "movieDescription")
            movie.setValue(imageName, forKey: "movieImageName")
            movieDb.append(movie)
        }
        updateDatabase()
    }
    
    func getMovie(_ indexPath: IndexPath) -> Movie
    {
        return movieDb[indexPath.row]
    }
}
