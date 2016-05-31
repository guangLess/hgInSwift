//
//  HgPhotoAlbumCustomlized.swift
//  codeTestHg
//
//  Created by Guang on 5/31/16.
//  Copyright © 2016 Guang. All rights reserved.
//

/*
import Photos

class HgPhotoAlbumCustomlized {
    
    static let albumName = "fromHGApp📖"
    static let sharedInstance = HgPhotoAlbumCustomlized()
    var photoCollection: PHAssetCollection!
    
    init() {
        func getAssetCollectionForAlbum() -> PHAssetCollection! {
            let fetchOptions = PHFetchOptions()
            fetchOptions.predicate = NSPredicate(format: "title = %@", HgPhotoAlbumCustomlized.albumName)
            let collection = PHAssetCollection.fetchAssetCollectionsWithType(.Album, subtype: .Any, options: fetchOptions)
            if let firstObject: AnyObject = collection.firstObject{
                return collection.firstObject as! PHAssetCollection
            }
            return nil
        }
        if let asserCollection = getAssetCollectionForAlbum(){
            self.photoCollection = asserCollection
            return
        }
        
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollectionWithTitle(HgPhotoAlbumCustomlized.albumName)
        }) { success, _ in
            if success {
                self.photoCollection = getAssetCollectionForAlbum()
            }
        }

    }
    
    func saveImage(image: UIImage) {
        if photoCollection == nil {
            return   // If there was an error upstream, skip the save.
        }
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAssetFromImage(image)
            let assetPlaceholder = assetChangeRequest.placeholderForCreatedAsset
            let albumChangeRequest = PHAssetCollectionChangeRequest(forAssetCollection: self.photoCollection)
            albumChangeRequest!.addAssets([assetPlaceholder!])
            }, completionHandler: nil)
    }
}
 */
