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

import PhotosUI


class CollectionImageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectinView: UICollectionView!
    let hgImageDataStore: DataStore  = DataStore.sharedInstance
    
    private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("videDidLoad called")
        
        collectinView.dataSource = self
        collectinView.delegate = self
        
        hgImageDataStore.tryApicall {_ in
            print("We are completing done.")
            dispatch_async(dispatch_get_main_queue(),{
                                //print("We are good!!!!")
                            self.collectinView.reloadData()
            })
        }
         cellLayOutSetUP()
        
//        let saveImageClass = SaveImageFromApp()
//        saveImageClass.status()
        //checkPhotoLibraryStatus()
        

    }
    
    
    func checkPhotoLibraryStatus () {
        
        if PHPhotoLibrary.authorizationStatus() == .Authorized {
            print("Authorized")
        } else {
            PHPhotoLibrary.requestAuthorization({ (PHAuthorizationStatus) in
                print ("need to authorize")
            })
        }
    }
    

    
    override func viewWillLayoutSubviews () {
        print("viewWillLayoutSubviews called")
    }
    
    func cellLayOutSetUP () {
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let screenBound = UIScreen.mainScreen().bounds
        let width = screenBound.size.width
        //let height = screenBound.size.height
        
        layout.itemSize = CGSize(width:(width)/3, height: (width)/3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectinView.collectionViewLayout = layout
   
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //print("Number of items in section printing")
        return self.hgImageDataStore.pictureArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCell
        //print("cellForItemAtIndexPath ")
        cell.spinner.startAnimating()
        let imageObject = self.hgImageDataStore.pictureArray[indexPath.row]
        cell.imageName.text = imageObject.name
        
        Alamofire.request(.GET, imageObject.url)
            .responseImage { response in
                debugPrint(response)
                print(response.request)
                print(response.response)
                debugPrint(response.result)
                if let image = response.result.value {
                    //print("image downloaded: \(image)")
                    dispatch_async(dispatch_get_main_queue(),{
                        cell.imageView.image = image
                        imageObject.image = image
                        self.stopSpinAction(cell)
                    })
                } else {
                    let noImagePlaceholder = UIImage(named: "noImage")
                    imageObject.image = noImagePlaceholder
                    cell.imageView.image = noImagePlaceholder
                    self.stopSpinAction(cell)
                }
                cell.imageView.contentMode = .ScaleAspectFill
        }
        return cell
    }
    
    func stopSpinAction(cell:ImageCell) {
        cell.spinner.stopAnimating()
        cell.spinner.hidden = true
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let pageSapceKey = [UIPageViewControllerOptionInterPageSpacingKey : 20]
        let pageVC = PageViewController.init(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: .Horizontal, options: pageSapceKey)
        pageVC.imageObjects = self.hgImageDataStore.pictureArray
        pageVC.tappedCellIndex = indexPath.row
        self.navigationController?.pushViewController(pageVC, animated: true)
        print("selected cell #\(indexPath.item)!")
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue{
            print ("landscape")
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            
        } else {
            print ("Portrait")
        }
    }
}

