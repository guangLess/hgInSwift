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
        //FIXME: helper method to setup the hidden views. Is it good to have views hidden and just hide there?
        //popUpView.hidden = true
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
    
//    @IBAction func shareButtonTest(sender: AnyObject) {
//
//        print ("button share called")
//    //let shareImage = UIImage(named: "PM")!
//        if let shareImage = imageView.image {
//        let imageVC = UIActivityViewController(activityItems: [shareImage], applicationActivities: [])
//        //activityViewController.excludedActivityTypes = [ UIActivityTypePostToTwitter]
//        // activityViewController.excludedActivityTypes = [UIActivityTypePostToTwitter, UIActivityTypePostToFacebook, UIActivityTypeSaveToCameraRoll, UIActivityTypeMessage]
//        navigationController?.presentViewController(imageVC, animated: true) {
//            // add alertview
//        }
//           // self.popUpSavedView()
//
//        }
//    }
    
    @IBOutlet weak var popUpViewBottomConstrain: NSLayoutConstraint!
    @IBOutlet weak var popUpView: UILabel!
    //FIXME: add animation for the page movement. Animate the bond of the frame. The popUp should be a trangle color block.
    
    @IBAction func TestAnimationButton(sender: AnyObject) {
            popUpSavedView()
        
    }
    
    func popUpSavedView (){
        popUpView.hidden = false
/*
         let duration = 2.0
         let delay = 0.0
         let options = UIViewKeyframeAnimationOptions.CalculationModeLinear
         
         UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
         // each keyframe needs to be added here
         // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
         
         UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: {
         // start at 0.00s (5s × 0)
         // duration 1.67s (5s × 1/3)
         // end at   1.67s (0.00s + 1.67s)
         self.fish.transform = CGAffineTransformMakeRotation(1/3 * fullRotation)
         })
         UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
         self.fish.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
         })
         UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
         self.fish.transform = CGAffineTransformMakeRotation(3/3 * fullRotation)
         })
         
         }, completion: {finished in
         // any code entered here will be applied
         // once the animation has completed
         
         })
         }
 */
        
        //TODO: try animation in a different xcode project.
        
        UIView.animateKeyframesWithDuration(4, delay: 0.3, options: UIViewKeyframeAnimationOptions.CalculationModeLinear, animations: {
            //code
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1, animations: {
                self.popUpView.backgroundColor = UIColor.blackColor()
            })
            
            UIView.addKeyframeWithRelativeStartTime(2, relativeDuration: 1/3, animations: {
                self.popUpView.backgroundColor = UIColor.redColor()
            })
            UIView.addKeyframeWithRelativeStartTime(3, relativeDuration: 1/3, animations: {
                self.popUpViewBottomConstrain.constant = 130
            })
            
            }) { (Bool) in
                //
        }

       // })
        
    }
}
