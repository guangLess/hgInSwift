//
//  ContentViewController.swift
//  pageVCswift
//
//  Created by Guang on 4/13/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit


class ContentViewController: UIViewController, UIScrollViewDelegate {

    var imageObject: ImageObject?
    var indexNumber : String = ""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    //@IBOutlet weak var actualImageScrollView: UIScrollView!

    var imageViewTwo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //imageViewTwo = UIImageView(image: UIImage(named: "PM"))
//        actualImageScrollView.backgroundColor = UIColor.brownColor()
//        actualImageScrollView.addSubview(imageViewTwo!)
//        
//        let doubleTap = UITapGestureRecognizer(target: self, action: #selector( doubleTapAction(_:)))
//        doubleTap.numberOfTapsRequired = 2
//        actualImageScrollView.addGestureRecognizer(doubleTap)
//
//        actualImageScrollView.delegate = self
//        setZoomScale()

        print("viewDidLoad of ContentViewController called")
    }

 
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let imageToDisplay = imageObject?.image {
            imageView.image = imageToDisplay
        } else {
            imageView.image = UIImage(named: "PM")
        }
    }
      /*
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        if let imageToDisplay = imageObject?.image {
//            imageViewTwo.image = imageToDisplay
//            //imageViewTwo.image = imageToDisplay
//        } else {
//            imageViewTwo.image = UIImage(named: "PM")
//            //imageViewTwo.image = UIImage(named: "noImage")
//        }
//    }
//    
    
//    override func viewDidLayoutSubviews() {
//        setZoomScale()
//    }
    
    func doubleTapAction(gestureRecognizer: UIGestureRecognizer) {
        print("guesture tap")
        actualImageScrollView.backgroundColor = UIColor.redColor()

        if (actualImageScrollView.zoomScale >= 1) {
        actualImageScrollView.setZoomScale(0.10, animated: true)
            print("guesture zoom in")

        } else {
        actualImageScrollView.setZoomScale(3, animated: true)
            print("guesture zoom out")
        }
    }

    func setZoomScale() {
        let imageViewSize = imageViewTwo.bounds.size
        let scrollViewSize = actualImageScrollView.bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        actualImageScrollView.minimumZoomScale = min(widthScale, heightScale)
        actualImageScrollView.zoomScale = 1.0
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let imageViewSize = imageViewTwo.frame.size
        let scrollViewSize = actualImageScrollView.bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        actualImageScrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    
    }
    
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageViewTwo
    }
*/
    
}