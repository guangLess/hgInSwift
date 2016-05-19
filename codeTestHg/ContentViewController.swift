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
    private var imageView = UIImageView()
    private var scrollView = UIScrollView()
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
        scrollView.frame = CGRectMake(0, 0, self.view.frame.width, view.frame.height)  //view.frame.height)
        scrollView.backgroundColor = UIColor.clearColor() //UIColor.cyanColor()
        scrollView.contentSize = CGSizeMake(self.view.frame.width, view.frame.height) // set it at first and then tap to move it
        scrollView.bounces = false
        
        imageView.contentMode = .ScaleAspectFit
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector( doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        
       // progressView.setProgress(0, animated: true)
        print("viewDidLoad of ContentViewController called")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let imageToDisplay = imageObject?.image {
            imageView.image = imageToDisplay
        } else {
            //imageView.image = UIImage(named: "PM")
            activeProgess()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        imageView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
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
        if (scrollView.zoomScale > 1) {
            scrollView.setZoomScale(0.25, animated: true)
        } else {
            scrollView.setZoomScale(2, animated: true)
        }
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