//
//  CollectionImageViewController.swift
//  codeTestHg
//
//  Created by Guang on 4/8/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire


//let hgImageDataStore = DataStore.sharedInstance


class CollectionImageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectinView: UICollectionView!
    let hgImageDataStore: DataStore  = DataStore.sharedInstance
    //var photos = [UIImage]()
    
    //var imageCollectionArray = [ImageObject]() // write a helper method to resize the image
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("videDidLoad called")
        
        collectinView.dataSource = self
        collectinView.delegate = self
        
       // NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(weAreGood), name: "ImageDownloaded", object: nil)
        
        hgImageDataStore.tryApicall {_ in
            print("We are completing done.")
            //self.imageCollectionArray = self.hgImageDataStore.pictureArray
            dispatch_async(dispatch_get_main_queue(),{
                                print("We are good!!!!")
                            self.collectinView.reloadData()
            })
        }
        print("ARE WE GETTING CALLED JIM!!!")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("Number of items in section printing")
        return self.hgImageDataStore.pictureArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCell
        //print(indexPath.row)
        
        print("cellForItemAtIndexPath ")
        //        if let imageUrl = NSURL(string: self.imageCollectionArray[indexPath.row].url) {
        //            if let imageData = NSData(contentsOfURL: imageUrl){
        //                cell.image.image = UIImage(data:imageData)  // if else to struct
        //            } else {
        //                cell.image.image = UIImage(named:"noImage")
        //            }
        //        }
        let imageObject = self.hgImageDataStore.pictureArray[indexPath.row]
        cell.imageName.text = imageObject.name
        //cell.image.image = self.loadImage(cellObject.url)
        
        
        Alamofire.request(.GET, imageObject.url)
            .responseImage { response in
                debugPrint(response)
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                if let image = response.result.value {
                    print("image downloaded: \(image)")
                    dispatch_async(dispatch_get_main_queue(),{
                        // no need to do this: UIImageView will handle resizing via contentMode
//                    let aspectScaledToFillImage = image.af_imageAspectScaledToFillSize(CGSize(width: 150, height: 150))
//                    cell.image.image = aspectScaledToFillImage
//                        cell.image
                        cell.imageView.image = image
                        imageObject.image = image
                    })
                } else {
                    let noImagePlaceholder = UIImage(named: "noImage")
                    imageObject.image = noImagePlaceholder
                    cell.imageView.image = noImagePlaceholder
                }
                cell.imageView.contentMode = .ScaleAspectFill
        }
        return cell
    }
    
//    func loadImage (loadImageURL : String) -> UIImage {
//        /*
//         Alamofire.request(.GET, "https://httpbin.org/image/png")
//         .responseImage { response in
//         debugPrint(response)
//         
//         print(response.request)
//         print(response.response)
//         debugPrint(response.result)
//         
//         if let image = response.result.value {
//         print("image downloaded: \(image)")
//         }
//         }
//         */
//
//    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pageVC = PageViewController()
        pageVC.imageObjects = self.hgImageDataStore.pictureArray

        self.navigationController?.pushViewController(pageVC, animated: true)
        print("selected cell #\(indexPath.item)!")
    }
  
}

