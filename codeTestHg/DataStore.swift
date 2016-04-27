//
//  DataStore.swift
//  codeTestHg
//
//  Created by Guang on 4/9/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import Foundation
import Alamofire
import Toucan
import UIKit

class DataStore {
    
    /*
     
Things to Change: imageObject make it to class not strct : read strct and class
                  lazy loading for the data as string first
                  then alamofire for the image
     */
    
    
    static let sharedInstance = DataStore()
    var pictureArray = [ImageObject]()
    
    init(){}
    
    
    func tryApicall(completion: ([[String: String]]) -> Void) // maybe make a agument so you can take the agument. maybe struc
    {
        //var pictureArray = [ImageObject]()
        
        let apiUrl = "https://hinge-homework.s3.amazonaws.com/client/services/homework.json"
        Alamofire.request(.GET, apiUrl).responseJSON {
            response in
            
            guard response.result.error == nil
                else {
                    print("Error. \(response.result.error?.localizedDescription)")
                    return
            }
            if response.result.isSuccess {
                
                completion(response.result.value as! [[String: String]])
                var i = 0
                for eachImage in response.result.value as! [[String : String]] {
                    i+=1
                    print("We have an image!\(i))")
                    
                    
//                    self.getTheImageObject(eachImage, completion: { eachImageObject in
//                        self.pictureArray.append(eachImageObject)
//                        print("About to post notification!")
//                        print("Picture Array contains \(self.pictureArray.count) objects")
//                        //NSNotificationCenter.defaultCenter().postNotificationName("ImageDownloaded", object: nil)
//                        
//                    })
                    let eachImageObject = ImageObject(url:eachImage["imageURL"]!, description: eachImage["imageDescription"]!, name: eachImage["imageName"]!,imageNumber:String(i))
                    self.pictureArray.append(eachImageObject)
       }
            }
            //}
            //print(self.pictureArray[0])
        }
    }
    
//    func getTheImageObject(image: [String: String], completion: (ImageObject) -> ()) {
//        
//        //let rawImage = self.setImageFrom(image["imageURL"])
//        
//        //let resizeImage = Toucan.Resize.resizeImage(rawImage, size: CGSize(width: 200, height: 200))
//        
//        let eachImageObject = ImageObject(url:image["imageURL"]!, description: image["imageDescription"]!, name: image["imageName"]!)
//        
//        completion(eachImageObject)
//    }
//    
//    
//    //MARK : image placement and resize maybe use strac
//    func setImageFrom(urlString : String?) -> UIImage {
//        var returnImage : UIImage
//        let imageURL = NSURL(string: urlString!)
//
//        if let imageData = NSData(contentsOfURL:imageURL!){
//            returnImage = UIImage(data: imageData)!
//        }
//        else {
//            returnImage = UIImage(named:"noImage")!
//        }
//        return returnImage
//    }
}
