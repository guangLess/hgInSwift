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
    private var imageView = UIImageView()
    private var scrollView = UIScrollView()
    private var centerX: NSLayoutConstraint!
    private var centerY: NSLayoutConstraint!
    
    var counter: Int = 0 {
        didSet{
        let fractionalProgress = Float(counter) / 100.0
        let animated = counter != 0
        progressView.setProgress(fractionalProgress, animated: animated)
        progressLabel.text = ("\(counter)%")
        }
   
    }
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.blueColor() //UIColor.cyanColor()
        scrollView.bounces = false
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        scrollView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        scrollView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        scrollView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraintEqualToAnchor(scrollView.widthAnchor).active = true
//        imageView.heightAnchor.constraintEqualToAnchor(scrollView
//            .heightAnchor, multiplier: 0.33).active = true
       centerX =  imageView.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor)
        centerY = imageView.centerYAnchor.constraintEqualToAnchor(scrollView.centerYAnchor)
        centerX.active = true
        centerY.active = true
        
        
        imageView.backgroundColor = UIColor.blackColor()
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        
    
        scrollView.contentSize = imageView.bounds.size
        
//        scrollView.maximumZoomScale = 3
//        scrollView.minimumZoomScale = 1
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector( doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        
       // progressView.setProgress(0, animated: true)
        print("viewDidLoad of ContentViewController called")
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {
      
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.5
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let imageToDisplay = imageObject?.image {
            imageView.image = imageToDisplay
            scrollView.contentSize = imageView.bounds.size

//            scrollView.contentSize = CGSizeMake(imageView.frame.width, imageView.frame.height) // set it at first and then tap to move it
            print("content size of scrollView: \(scrollView.contentSize)")

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
        
//        scrollView.backgroundColor = UIColor.redColor()
//        print(scrollView.frame)
//        print(view.frame)
        
        if scrollView.zoomScale > 1.0 {
            
            UIView.animateWithDuration(0.3, animations: { _ in
                
                self.centerY.constant = 0.0
                self.scrollView.setZoomScale(1.0, animated: true)

                self.view.layoutIfNeeded()

                }, completion: { _ in

            })
            
            
            
        } else {
            UIView.animateWithDuration(0.3, animations: { _ in
                
                self.centerY.constant = -30.0
                self.scrollView.setZoomScale(2.5, animated: true)

                self.view.layoutIfNeeded()

                
                }, completion: { _ in
                    
            })
            

            
        }
//
//        if (scrollView.zoomScale > 1.0) {
//            scrollView.setZoomScale(0.25, animated: true)
//        } else {
//            scrollView.setZoomScale(2, animated: true)
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
}