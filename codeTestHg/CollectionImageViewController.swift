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

//TODO: add refresh controller with icon. Take out button share stuff. save image with album...
class CollectionImageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectinView: UICollectionView!
    let hgImageDataStore: DataStore  = DataStore.sharedInstance
    private let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectinView.dataSource = self
        collectinView.delegate = self
        updateUI()
        cellLayOutSetUP()
        checkPhotoLibraryStatus()
    }
    
    func updateUI () {
        hgImageDataStore.tryApicall {_ in
            dispatch_async(dispatch_get_main_queue(),{
                self.collectinView.reloadData()
            })
        }
    }
    
    func checkPhotoLibraryStatus () {
        if PHPhotoLibrary.authorizationStatus() == .Authorized {
            print("Authorized") //TOFIX: is there a better way to handle this?
        } else {
            PHPhotoLibrary.requestAuthorization({ (PHAuthorizationStatus) in
                print ("need to authorize")
            })
        }
    }
    
    func cellLayOutSetUP () {
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let screenBound = UIScreen.mainScreen().bounds
        let width = screenBound.size.width
        layout.itemSize = CGSize(width:(width)/3, height: (width)/3)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectinView.collectionViewLayout = layout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: collectionView delegate/dataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hgImageDataStore.pictureArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! ImageCell
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