//
//  AppError.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 8/31/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit

enum ErrorType:Int{
    case NoConnectionError
    case EmptyResults
    case ApiFailure
}

class AppError: Error {
    
    var errorType : ErrorType
    var errorMessage : String
    
    init(type: ErrorType) {
        errorType = type
        errorMessage = ""
    }
    
    

}
