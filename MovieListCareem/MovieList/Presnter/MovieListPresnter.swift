//
//  MovieListPresnter.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 8/31/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit

class MovieListPresnter: NSObject {
    
    //Variables
    var pageIndex : Int
    var canLoadMoreData : Bool
    
    override init() {
        pageIndex = 2
        canLoadMoreData = true
    }
    
    func loadMovieList(query:String,completionHandler: @escaping ([Movie]?,AppError?) -> Void)  {
        // check if can load more date first
        if !self.canLoadMoreData
        {
            completionHandler([Movie](), nil)
        }else
        {
            // load more movies with new page index
            NetworkManager.getMoviesList(query: query, page: pageIndex) { (result) in
                switch result{
                case .success(let items):
                    self.pageIndex += 1
                    completionHandler(items, nil)
                case .failure(var appeError ):
                    if (appeError as! AppError).errorType == ErrorType.EmptyResults
                    {
                        self.canLoadMoreData = false
                    }
                    appeError = self.handleErrorMEssage(error: appeError as! AppError)
                    completionHandler(nil, appeError as? AppError)
                    
                }
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
            error.errorMessage = "ListEmptyErrorMessage".localized()
        }
        return error
    }
    
    
}
