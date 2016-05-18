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
    
    
    //@IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.delegate = self
        scrollView.frame = CGRectMake(0, 0, self.view.frame.width, view.frame.height)  //view.frame.height)
        scrollView.backgroundColor = UIColor.cyanColor()
        scrollView.contentSize = CGSizeMake(self.view.frame.width, view.frame.height) // set it at first and then tap to move it
        scrollView.bounces = false
        //imageView.image = UIImage(named:"PM")
        
        imageView.contentMode = .ScaleAspectFit
        
        scrollView.addSubview(imageView)
        view.addSubview(scrollView)
        
        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector( doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
        
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
   
}