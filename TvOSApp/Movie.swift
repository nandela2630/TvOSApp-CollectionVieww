//
//  Movie.swift
//  TvOSApp
//
//  Created by wflogin on 9/15/15.
//  Copyright © 2015 wflogin. All rights reserved.
//

import Foundation

class Movie {
    
    
    let URL_BASE = "http://image.tmdb.org/t/p/w500"
    var title : NSString!
    var overview: NSString!
    var posterpath:NSString!
    
    init(movieDict:  Dictionary<String, AnyObject>){
        
        if let title = movieDict["title"] as? String
        {
            
            
         self.title = title
        }
        if let overview = movieDict["overview"] as? String
        {
         self.overview = overview
        }
        if let path = movieDict["poster_path"] as? String
        {
        
        self.posterpath = "\(URL_BASE)\(path)"
            
        }
    
    
    }
    
}