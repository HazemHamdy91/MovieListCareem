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
    
    
    func getQueryHistory()-> [String] {
        return StorageManager.getQuriesHistory()
    }
    
    func loadMovieList(query:String,completionHandler: @escaping ([Movie]?,AppError?) -> Void)  {
        NetworkManager.getMoviesList(query: query, page: 1) { (result) in
            switch result{
            case .success(let items):
                StorageManager.saveSuccessfulQuery(query: query)
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
            error.errorMessage = "NoConnectionErrorMessage".LocalizedString()
        case ErrorType.ApiFailure:
            error.errorMessage = "GeneralErrorMessage".LocalizedString()
        case ErrorType.EmptyResults:
            error.errorMessage = "SearchEmptyErrorMessage".LocalizedString()
        }
        return error
    }

}


// Override pod Localize to read from specific file

public extension String
{
     func LocalizedString() -> String {
       return self.localized(using: "Strings")
    }
}
