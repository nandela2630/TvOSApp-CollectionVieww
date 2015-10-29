//
//  MovieCell.swift
//  TvOSApp
//
//  Created by wflogin on 9/15/15.
//  Copyright © 2015 wflogin. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImg : UIImageView!
    @IBOutlet weak var movieLbl : UILabel!
    
    func configureCell(movie:  Movie)
    {
       
    if let title = movie.title
    {
        
 movieLbl.text = title as String
        
        
        }
        if let path = movie.posterpath{
        
        let url = NSURL(string:  path as String)!
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))
                {
                  let data = NSData(contentsOfURL: url)!
                    
                    dispatch_async( dispatch_get_main_queue()){
                    
                    let img = UIImage(data: data)
                        
                        self.movieImg.image = img
                        
                    }
            
               }
            
            
            
        }
       
        
        }
        
        
    }
