//
//  SearchPresnter.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 8/31/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit
import Localize_Swift

class SearchPresnter: NSObject {
    
    func loadMovieList(query:String,completionHandler: @escaping ([Movie]?,AppError?) -> Void)  {
        NetworkManager.getMoviesList(query: query, page: 1) { (result) in
            switch result{
            case .success(let items):
                completionHandler(items, nil)
            case .failure(var appeError):
                appeError = self.handleErrorMEssage(error: appeError as! AppError)
                completionHandler(nil, appeError as? AppError)
            }
        }
        
    }
    
    func handleErrorMEssage(error : AppError) -> AppError {
        switch error.errorType {
        case ErrorType.NoConnectionError:
            error.errorMessage = "NoConnectionErrorMessage".localized()
        case ErrorType.ApiFailure:
            error.errorMessage = "GeneralErrorMessage".localized()
        case ErrorType.EmptyResults:
            error.errorMessage = "SearchEmptyErrorMessage".localized()
        }
        return error
    }
    
    

}
