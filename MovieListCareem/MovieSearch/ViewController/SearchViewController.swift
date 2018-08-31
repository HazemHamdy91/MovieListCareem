//
//  SearchViewController.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 8/31/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
  
    
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
    
    // IBActions
    @IBAction func searchAction(_ sender: Any) {
        if self.queryTextField.text != ""
        {
            
        }else
        {
            self.showAlert(title: "Error", message: "Please enter valid input", dismissButtonText: "OK")
        }
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
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController
{
    func showAlert(title : String , message:String , dismissButtonText:String)  {
        
        let alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: dismissButtonText , style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
