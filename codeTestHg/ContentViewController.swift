//
//  ContentViewController.swift
//  pageVCswift
//
//  Created by Guang on 4/13/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit
import Photos
//TODO: use the AssetsLibrary to just the creat the album and then share extention for share and text etc.
import AssetsLibrary


/*
 scrollview delegate. check.  page should know the size of the image before it passes to the content.
 */

//FIXME: tap to enlarge the image. clean code. Add save function

class ContentViewController: UIViewController, UIScrollViewDelegate {
    
    var imageObject: ImageObject?
    var indexNumber : String = ""
    
    private var scrollView = UIScrollView()

    var nativeSize = CGSizeMake(0, 0)
    private var imageView = UIImageView()
    
    //private var centerX: NSLayoutConstraint!
    //private var centerY: NSLayoutConstraint!
    
    @IBOutlet weak var indexLabel: UILabel!
    private var fittedImage: UIImage!

    @IBOutlet weak var fittedImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
    
    //FIXME: put into helpper method
        view.addSubview(scrollView)
        view.addSubview(imageView)
        
        setImageViewConstrainsWhenLoad(view.frame.width, h: view.frame.height)
        fittedImageView.hidden = true
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        //print("viewDidLoad of ContentViewController called")
    }

    private func setImageViewConstrainsWhenLoad ( w: CGFloat, h: CGFloat) {
        
        imageView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor).active = true
        imageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor).active = true
        //imageView.frame = CGRect(x: 10, y: 10, width: view.frame.width, height: view.frame.height)
        imageView.frame = CGRect(x: 0, y: 10, width: w , height: h)

        //imageView.frame =  CGRect (x: 0, y:(self.navigationController?.navigationBar.frame.height)!, width: nativeSize.width, height: nativeSize.height)
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
             print (nativeSize)
            fittedImageView.image = imageToDisplay

        } else {
            imageView.image = UIImage(named: "PM")
            fittedImageView.image = UIImage(named: "PM")
        }
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//    }
    
//    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
//        return imageView
//    }
//    
//    func scrollViewDidZoom(scrollView: UIScrollView) {
//    }
    
    func doubleTapAction() {
//        print ("image Tapped")
//        scrollView.backgroundColor = UIColor.redColor()
//        print(nativeSize)
//        print(imageView.image?.size)
//        print("imageView.frame.width = \(imageView.frame.width) view.frame.width = \(view.frame.width) ")
  
        //if (scrollView.contentSize == nativeSize)
        
        
        if (nativeSize.width < view.frame.width) {
        //if ( fittedImageView.hidden == true ){
            print("scroll view is already enlarged, the user do not need to see the bad picture, or ")

        } else if (imageView.bounds.width > view.frame.size.width ) {
            scrollView.hidden = true
            fittedImageView.hidden = false
        }
        else {
//        fittedImageView.hidden = true
//            
//         scrollView.hidden = false
//         imageView.hidden = false
            
        scrollView.addSubview(imageView) // before
        //scrollView.contentSize = nativeSize

//        imageView.frame =  CGRect (x: 0, y:(self.navigationController?.navigationBar.frame.height)!
//                , width: nativeSize.width, height: nativeSize.height)
//       // imageView.centerYAnchor.constraintEqualToAnchor(scrollView.centerYAnchor).active = true
//        imageView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor).active = true
//        imageView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor).active = true
//        imageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor).active = true
        
        setImageViewConstrainsWhenLoad(nativeSize.width, h: nativeSize.height)
        scrollView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)!, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = nativeSize
        scrollView.bounces = true
            
        }
    }
    
    private func updateConstraintsForSize(size: CGSize) {
    }
    
    func saveImageOnThisContentView () {

        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ 
            let createAlbumeRequest = PHAssetCollectionChangeRequest()
            PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle("hello world")
            //createAlbumeRequest.title = "Hello world"
            var placeHolder = PHObjectPlaceholder()
            placeHolder = createAlbumeRequest.placeholderForCreatedAssetCollection
            }) { (Bool, error) in
                print ("error")
        }
    }
 /*
    func addImageToAlbum (saveImage : UIImage) {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ 
            PHAssetChangeRequest.creationRequestForAssetFromImage(saveImage)
            let assetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(saveImage)

            
//            PHAssetCollectionChangeRequest.
//            
//        }) { (<#Bool#>, <#NSError?#>) in
//                <#code#>
        }
    }
*/
    
    @IBAction func shareButtonTest(sender: AnyObject) {

        print ("button share called")

        let shareImage = UIImage(named: "PM")!
        let imageVC = UIActivityViewController(activityItems: [shareImage], applicationActivities: [])
        //activityViewController.excludedActivityTypes = [ UIActivityTypePostToTwitter]
        // activityViewController.excludedActivityTypes = [UIActivityTypePostToTwitter, UIActivityTypePostToFacebook, UIActivityTypeSaveToCameraRoll, UIActivityTypeMessage]
        navigationController?.presentViewController(imageVC, animated: true) {
            // ...
        }
    }
}