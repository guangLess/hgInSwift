//
//  ImageObject.swift
//  codeTestHg
//
//  Created by Guang on 4/9/16.
//  Copyright © 2016 Guang. All rights reserved.
//

//import Foundation
import UIKit

class ImageObject {
    var url = ""
    var description = ""
    var name = ""
    var imageNumber = ""
    var image: UIImage?

    init(url:String, description:String, name:String, imageNumber:String){
        self.url = url
        self.description = description
        self.name = name
        self.imageNumber = imageNumber
    }
}

