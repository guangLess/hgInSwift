//
//  ContentViewController.swift
//  pageVCswift
//
//  Created by Guang on 4/13/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit


/*
 scrollview delegate. check.  page should know the size of the image before it passes to the content.
 */
class ContentViewController: UIViewController, UIScrollViewDelegate {
    
    var imageObject: ImageObject?
    var indexNumber : String = ""
    
    var nativeSize = CGSizeMake(0, 0)
    private var imageView = UIImageView()
    
    private var scrollView = UIScrollView()
    
    private var centerX: NSLayoutConstraint!
    private var centerY: NSLayoutConstraint!
    
    
    @IBOutlet weak var indexLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        //scrollView.backgroundColor = UIColor.blueColor() //UIColor.cyanColor()
        scrollView.bounces = false
        
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        scrollView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        scrollView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        scrollView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        
        scrollView.contentSize = CGSizeMake(view.frame.width, view.frame.height)

        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1

    
        scrollView.addSubview(imageView)
        
        
        imageView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor).active = true
        imageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor).active = true
        
        imageView.frame = CGRect(x: 10, y: 10, width: view.frame.width, height: view.frame.height)
        
        //centerX = imageView.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor)
        //centerY = imageView.centerYAnchor.constraintEqualToAnchor(scrollView.centerYAnchor)
        //centerX.active = true
        //centerY.active = true
        
        view.addSubview(imageView)
   
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector( doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        
        print("viewDidLoad of ContentViewController called")
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {
  
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.5
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView.contentMode = .ScaleAspectFit
        imageView.backgroundColor = UIColor.brownColor()

        if let imageToDisplay = imageObject?.image {
            imageView.image = imageToDisplay
            nativeSize = CGSize(width: imageToDisplay.size.width, height: imageToDisplay.size.height)
            //scrollView.contentSize = nativeSize
             print (nativeSize)

        } else {
            imageView.image = UIImage(named: "PM")
            //activeProgess()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateMinZoomScaleForSize(view.bounds.size)

//        scrollView.frame = view.bounds
 //       imageView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(scrollView: UIScrollView) {

        //self.imageView.contentMode = .Center
        //scrollView.contentInset = UIEdgeInsetsZero;
    }
    
    func doubleTapAction() {
        print ("image Tapped")
        scrollView.backgroundColor = UIColor.redColor()
        print(nativeSize)
        print(imageView.image?.size)
        print("imageView.frame.width = \(imageView.frame.width) view.frame.width = \(view.frame.width) ")
        
        
        if (nativeSize.width < view.frame.width || scrollView.contentSize.width > view.frame.width) {
            print("scroll view goes back to fit the screen")
            scrollView.contentSize = CGSizeMake(view.frame.width, view.frame.height)
        } else {
        
        imageView.bounds =  CGRect (x: 0, y: 0, width: nativeSize.width, height: nativeSize.height)
        
        scrollView.addSubview(imageView)
        imageView.centerYAnchor.constraintEqualToAnchor(scrollView.centerYAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor).active = true
        imageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor).active = true
        scrollView.contentSize = nativeSize
        imageView.contentMode = .ScaleAspectFit
        imageView.clipsToBounds = true
        }
        //imageView.updateConstraints()
        //self.view.layoutIfNeeded()
//        print(scrollView.frame)
//        print(view.frame)
//
//        if (scrollView.zoomScale > 1.0) {
//            scrollView.setZoomScale(0.25, animated: true)
//            scrollView.contentSize = nativeSize
//            self.view.layoutIfNeeded()
//
//        } else {
//            scrollView.setZoomScale(2, animated: true)
//            scrollView.contentSize = nativeSize
//           self.view.layoutIfNeeded()
//        }
    }
    
    private func updateConstraintsForSize(size: CGSize) {
       
//        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
//        imageViewTopConstraint.constant = yOffset
//        imageViewBottomConstraint.constant = yOffset
//        
//        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
//        imageViewLeadingConstraint.constant = xOffset
//        imageViewTrailingConstraint.constant = xOffset
//        
//        view.layoutIfNeeded()
    }
/*
    func progressBarSetUp () {
        progressLabel.text = "0%"
        self.counter = 0
        for _ in 0..<100 {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
                sleep(1)
                dispatch_async(dispatch_get_main_queue(), {
                    self.counter+=1
                    return
                })
            })
        }
    }
    
    func activeProgess (){
        if  progressView.progress == 1.0 {
            progressView.hidden = true
            imageView.image = imageObject!.image
        } else {
            progressBarSetUp()
        }
    }
 
 */
}