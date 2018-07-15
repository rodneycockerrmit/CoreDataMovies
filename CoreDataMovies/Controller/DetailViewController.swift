//
//  ViewController.swift
//  CoreDataMovies
//
//  Created by Rodney Cocker on 6/7/18.
//  Copyright © 2018 RMIT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var currentMovie: Movie?
    
    @IBOutlet weak var movieImage: UIImageView!
    
    @IBOutlet weak var movieTitle: UITextField!
    
    @IBOutlet weak var movieImageName: UITextField!
    
    @IBOutlet weak var movieDescription: UITextView!
    
    @IBAction func save(_ sender: Any)
    {
        Model.sharedInstance.saveMovie(movie_name: movieTitle.text!, movie_desc: movieDescription.text!, imageName: movieImageName.text!, existing: currentMovie)
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let movie = currentMovie
        {
            movieImage.image = UIImage(named: movie.movieImageName!)
            movieTitle.text = movie.movieName
            movieImageName.text = movie.movieImageName
            movieDescription.text = movie.movieDescription
        }
        
        let modelNetworkRequest = MovieDBNetworkRequest()
        modelNetworkRequest.fetchMovies(withTitle: "Man of Steel")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

