//
//  MovieListViewController.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 8/31/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // Variables
    var moviePresnter = MovieListPresnter()
    var movieResults = [Movie]()
    var query = ""
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        // Dynamic Table View Cell hieght
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 103.0;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
     // MARK: - Pagination Methods
    
    func loadMoreMovies()  {
        self.showActivityIndicator()
        moviePresnter.loadMovieList(query: query, completionHandler: { (movies, appError) in
            self.hideActivityIndicator()
            if appError == nil && movies != nil
            {
                if movies!.count > 0
                {
                    self.movieResults.append(contentsOf: movies!)
                    self.tableView.reloadData()
                }
            }else
            {
                self.showAlert(title: "Error".LocalizedString(), message: appError?.errorMessage ?? "" , dismissButtonText: "OK".LocalizedString())
            }
        })
    }
    
    
    // MARK: - Handle Activity Methods
    func showActivityIndicator()  {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    func hideActivityIndicator(){
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MovieListViewController: UITableViewDelegate,UITableViewDataSource {
    
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MovieTableViewCell
        
        cell.configure(movie: movieResults[indexPath.item])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movieResults.count-1 {
           // load More data
            self.loadMoreMovies()
        }
    }
    
    
}
