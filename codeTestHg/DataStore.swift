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
    
    static let sharedInstance = DataStore()
    var pictureArray = [ImageObject]()
    
    init(){}
    
    func tryApicall(completion: ([[String: String]]) -> Void) {
        let apiUrl = "https://hinge-homework.s3.amazonaws.com/client/services/homework.json"
        Alamofire.request(.GET, apiUrl).responseJSON {  response in
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
                    let eachImageObject = ImageObject(url:eachImage["imageURL"]!, description: eachImage["imageDescription"]!, name: eachImage["imageName"]!,imageNumber:String(i))
                    self.pictureArray.append(eachImageObject)
                }
            }
        }
    }
}
