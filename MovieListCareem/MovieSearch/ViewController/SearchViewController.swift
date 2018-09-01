//
//  SearchViewController.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 8/31/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit
import Localize_Swift
import SVProgressHUD

class SearchViewController: UIViewController {
    
    //Variables
    var searchPresnter = SearchPresnter()
    var movieResults = [Movie]()
    
    // Outlets
    @IBOutlet weak var queryTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Add hide Keyboard Gesture
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // IBActions -- Validate Query and get results
    @IBAction func searchAction(_ sender: Any) {
        // Validate query Text
        if self.queryTextField.text != ""
        {
            // Load Movies with entered query
            self.showLoading()
            searchPresnter.loadMovieList(query:self.queryTextField.text! , completionHandler: { (movies, appError) in
                self.hideLoading()
                if appError == nil && movies != nil
                {
                    //Navigate to search Results with sending results
                    self.movieResults = movies ?? [Movie]()
                    self.performSegue(withIdentifier: "ShowResults", sender: nil)
                    
                }else
                {
                    self.showAlert(title: "Error".localized(), message: appError?.errorMessage ?? "" , dismissButtonText: "OK".localized())
                }
            })
            
        }else
        {
            self.showAlert(title: "Error".localized(), message: "ValidationError".localized(), dismissButtonText: "OK".localized())
        }
    }
    
    
    // MARK: - Helper Methods
    
    func showLoading()  {
        SVProgressHUD.show(withStatus: "loading")
        SVProgressHUD.setDefaultMaskType(.black)

    }
    func hideLoading()  {
        SVProgressHUD.dismiss()
    }
    
    
    // Hide Keyboard when touch outside
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
  
 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let movieListVC = segue.destination as! MovieListViewController
        movieListVC.movieResults = self.movieResults
        movieListVC.query = self.queryTextField.text!
    }
 

}

extension UIViewController
{
    func showAlert(title : String , message:String , dismissButtonText:String)  {
        
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: dismissButtonText , style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
