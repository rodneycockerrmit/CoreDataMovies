//
//  MovieDBNetworkRequest.swift
//  CoreDataMovies
//
//  Created by Rodney Cocker on 15/7/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import Foundation
import UIKit

class MovieDBNetworkRequest
{
    let session = URLSession.shared
    
    let BASE_URL: String = "https://api.themoviedb.org/4/"
    let SEARCH_MOVIE: String = "search/movie"
    let MOVIE_DETAILS: String = "movie/"
    let IMAGES_LOCATION: String = "images"
    let API_KEY:String = AppDelegate.apikey
    let ID_LENGTH: Int = 4
    
    func fetchMovies(withTitle:String)
    {
        let movieTitle = withTitle.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        guard let movTitle = movieTitle else{
            print("Something went wrong")
            return
        }
        let findMovieId = BASE_URL + SEARCH_MOVIE + API_KEY + "&query=" + movTitle
        
        if let findMovieUrl = URL(string: findMovieId)
        {
            let request = URLRequest(url: findMovieUrl)
            
            InitialiseTaskForGettingData(withRequest: request, element: "results")
        }
    }
    
    func InitialiseTaskForGettingData(withRequest request:URLRequest, element: String)
    {
        let task = session.dataTask(with: request, completionHandler: {data, response, downLoadError in
            
            if let error = downLoadError
            {
                print("\(error)")
                print("\(response)")
            }
            else
            {
                let parsedResult:Any!
                
                do
                {
                    try parsedResult = JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch let error as NSError
                {
                    parsedResult = nil
                }
                
                print(parsedResult)
                print()
                
                var movieId:String = ""
                if let moviesArray = (parsedResult as AnyObject).value(forKey: element) as? NSArray
                {
                    var movieId: String
                    
                    for m in moviesArray
                    {
                        let movie = m as! NSDictionary
                        
                        if movie.value(forKey: "original_title") as! String == "Man of Steel"
                        {
                            movieId = String(describing: movie.value(forKey: "id"))
                        }
                        break
                    }
                }
            }
        })
        task.resume()
    }
    
}
