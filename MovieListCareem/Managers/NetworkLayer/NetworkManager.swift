//
//  NetworkManager.swift
//  MovieListCareem
//
//  Created by Hazem Hamdy on 8/31/18.
//  Copyright © 2018 Hazem Hamdy. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class NetworkManager: NSObject {
    
    public static let baseURL: String = "http://api.themoviedb.org/3/search/movie"
    public static let baseImageURL: String = " http://image.tmdb.org/t/p/w185"
    public static let apiKey: String = "2696829a81b1b5827d515ff121700838"
    
    
    // Load Movies by querySting and Page number
    static func getMoviesList(query:String , page:Int ,completionHandler: @escaping (Result<[Movie]>) -> Void)
    {
        if NetworkReachabilityManager()!.isReachable
        {
            Alamofire.request("\(baseURL)?api_key=\(apiKey)&query=\(query)&page=\(page)" , method: .get , parameters: nil , encoding: JSONEncoding.default , headers: nil).responseJSON{
                (response: DataResponse<Any>) in
                print(response)
                if response.response?.statusCode == 200
                {
                    if let data = response.result.value as? [String:Any]
                    {
                        if let jsonArray = data["results"] as? [[String : Any]]
                        {
                            let items =  Mapper<Movie>().mapArray(JSONArray: jsonArray)
                            completionHandler(Result.success(items))
                        }
                        else
                        {
                            completionHandler(Result.failure(AppError.init(type: ErrorType.EmptyResults, message: "")))
                        }
                    }
                }else
                {
                    completionHandler(Result.failure(AppError.init(type: ErrorType.ApiFailure, message: "")))
                }
            }
            
        }else
        {
            completionHandler(Result.failure(AppError.init(type: ErrorType.NoConnectionError, message: "")))
        }
    }
    
}
