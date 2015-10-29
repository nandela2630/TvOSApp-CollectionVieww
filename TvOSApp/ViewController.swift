//
//  ViewController.swift
//  TvOSApp
//
//  Created by wflogin on 9/15/15.
//  Copyright © 2015 wflogin. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,  UICollectionViewDataSource {
    
    let URL_BASE = "http://api.themoviedb.org/3/movie/top_rated?api_key=5c8b700b45ef6ac5865526e2cfba2eff"
    
    @IBOutlet weak var collectionView : UICollectionView!
    //280,422 
    
    let defaulltSize = CGSizeMake(280, 422)
    
    let focusSize  = CGSizeMake(308, 464)
    
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    collectionView.delegate = self
        collectionView.dataSource = self
    downloadData()
        
        
    }

    
    
    func downloadData()
    {
        let url = NSURL(string: URL_BASE)
        
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
//        let data : NSData!
//        let response : NSURLResponse!
//        let error : NSError!
        
        let task = session.dataTaskWithRequest(request)
            { (data,response,error) -> Void in
            
            if error  != nil {
            
            
            }else
            {
               do
               {
                
                let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:  .AllowFragments) as?  Dictionary< String, AnyObject>
                
                if let results  =  dict!["results"] as?  [Dictionary<String, AnyObject>]
                {

                    
                    for obj in results{
                    
                    let movie = Movie(movieDict: obj)
                        self.movies.append(movie)
                        
                    }
                    //Main UI Thread
                    dispatch_async(dispatch_get_main_queue()){
                    self.collectionView.reloadData()
                    
                    }
                    
                    
                    
                }
                
                
                
               }catch{
                
                
                }
                
                }
    
    }
        task .resume()
        
}
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MovieCell", forIndexPath: indexPath) as? MovieCell{
        
        let movie = movies[indexPath.row]
            
            cell.configureCell(movie)
            
            
            if cell.gestureRecognizers?.count == nil{
            
                let tap = UITapGestureRecognizer(target: self, action: "tapped:")
                
                tap.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)]
                
                cell.addGestureRecognizer(tap)
            
            }
            
            
            return cell
            
        }else{
        return MovieCell()
        }

//        return UICollectionViewCell()
        
    }
    
    
    func tapped(gesture: UITapGestureRecognizer)
    {
    
    if let cell = gesture.view as? MovieCell
    {
        //Load the next view controller and pass in the movie
        print("tap detected")
        
        
    }
        
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
    
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count;
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        return CGSizeMake(343, 535);
        
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        
        if let prev = context.previouslyFocusedView as? MovieCell
        {
            
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                prev.movieImg.frame.size = self.defaulltSize
            })
        
        }
        if let next = context.nextFocusedView as? MovieCell
        {
        
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                
               next.movieImg.frame.size = self.focusSize
                
                
            })
        }
        
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

