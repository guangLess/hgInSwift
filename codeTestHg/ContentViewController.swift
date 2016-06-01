//
//  ContentViewController.swift
//  pageVCswift
//
//  Created by Guang on 4/13/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit
import Photos

import AssetsLibrary


/*
 scrollview delegate. check.  page should know the size of the image before it passes to the content.
 */

//FIXME: tap to enlarge the image. clean code. Add save function

class ContentViewController: UIViewController, UIScrollViewDelegate {
    
    var imageObject: ImageObject?
    var indexNumber : String = ""
    
    var nativeSize = CGSizeMake(0, 0)
    private var imageView = UIImageView()
    
    private var scrollView = UIScrollView()
    
    private var centerX: NSLayoutConstraint!
    private var centerY: NSLayoutConstraint!
    
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var fittedImageView: UIImageView!
    
    private var fittedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        //scrollView.backgroundColor = UIColor.blueColor() //UIColor.cyanColor()
        //scrollView.bounces = false
    
    //FIXME: put into helpper method
        view.addSubview(scrollView)
        
        //scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraintEqualToAnchor(view.topAnchor).active = true
        scrollView.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor).active = true
        scrollView.leftAnchor.constraintEqualToAnchor(view.leftAnchor).active = true
        scrollView.rightAnchor.constraintEqualToAnchor(view.rightAnchor).active = true
        //scrollView.contentSize = CGSizeMake(view.frame.width, view.frame.height)

        scrollView.maximumZoomScale = 3
        scrollView.minimumZoomScale = 1

    
        //scrollView.addSubview(imageView)
 
        
        view.addSubview(imageView)

        imageView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor).active = true
        imageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor).active = true
        imageView.frame = CGRect(x: 10, y: 10, width: view.frame.width, height: view.frame.height)
        
        //imageView.hidden = true
        
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector( doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTap)
        
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

        imageView.frame =  CGRect (x: 0, y:(self.navigationController?.navigationBar.frame.height)!
                , width: nativeSize.width, height: nativeSize.height)
            
        imageView.centerYAnchor.constraintEqualToAnchor(scrollView.centerYAnchor).active = true
        imageView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor).active = true
        imageView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor).active = true
        imageView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor).active = true


        //scrollView.frame = CGRect(x: 0, y: 0, width: nativeSize.width, height: nativeSize.height)
            scrollView.frame = CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.height)!, width: view.frame.width, height: view.frame.height)

        scrollView.contentSize = nativeSize

        scrollView.bounces = true

        }
        

    }
    
    private func updateConstraintsForSize(size: CGSize) {

    }
    
    func saveImageOnThisContentView () {
    
//        let img = UIImage(named: "PM")
//        let library = ALAssetsLibrary()
//        library.writeImageToSavedPhotosAlbum(<#T##imageRef: CGImage!##CGImage!#>, metadata: <#T##[NSObject : AnyObject]!#>, completionBlock: <#T##ALAssetsLibraryWriteImageCompletionBlock!##ALAssetsLibraryWriteImageCompletionBlock!##(NSURL!, NSError!) -> Void#>)
        
//        let createAssetRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
//        let assetPlaceholder = createAssetRequest.placeholderForCreatedAsset
//        let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: album)
//        albumChangeRequest.addAssets([assetPlaceholder])
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
    
     func imageSaved(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }

}