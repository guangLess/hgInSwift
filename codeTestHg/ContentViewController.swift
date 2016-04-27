//
//  ContentViewController.swift
//  pageVCswift
//
//  Created by Guang on 4/13/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit


class ContentViewController: UIViewController {

    var imageObject: ImageObject?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad of ContentViewController called")
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let imageToDisplay = imageObject?.image {
            imageView.image = imageToDisplay
        } else {
            imageView.image = UIImage(named: "noImage")
        }
    }
    
}
