//
//  PageViewController.swift
//  pageVCswift
//
//  Created by Guang on 4/13/16.
//  Copyright © 2016 Guang. All rights reserved.
//

import UIKit
import Alamofire


class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
   // let colors = [UIColor.whiteColor, UIColor.purpleColor, UIColor.greenColor]
   // let pageTitles = ["Hi", "✦", "◉"]
    var imageIndex = 0
    
    var imageObjects = [ImageObject]() {
        didSet {
            if !orderedViewControllers.isEmpty {
                orderedViewControllers.removeAll()
            }
            imageObjects.forEach { imageObject in
                let contentVC = newContentVC(imageObject: imageObject)
                orderedViewControllers.append(contentVC)
            }
        }
    }
    var orderedViewControllers = [ContentViewController]()
    var currentIndex : Int = 0
    var tappedCellIndex : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self

        view.backgroundColor = .blackColor()
        let aVC = orderedViewControllers[tappedCellIndex]
        self.setViewControllers([aVC], direction: .Forward, animated: true, completion: nil)
        
        //UIPageViewControllerOptionInterPageSpacingKey
        
    }
    
    func newContentVC(imageObject imageObject: ImageObject) -> ContentViewController {
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("contentVC") as! ContentViewController
        contentViewController.view.backgroundColor = .blackColor()
        contentViewController.title = imageObject.name
        contentViewController.indexLabel.text = "\(imageObject.imageNumber)/\(imageObjects.count) -\(imageObject.name) \(imageObject.description)"
        contentViewController.indexNumber = "\(imageObject.imageNumber)/\(imageObjects.count)"
        //print("contentViewController.indexLabel.text = \(contentViewController.indexLabel.text)")
        contentViewController.imageObject = imageObject // dont pass to the IMAGEVIEW; it doesnt exist yet! // pass to the PROPERTY :)

        return contentViewController
    }

    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController as! ContentViewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController,
                            viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.indexOf(viewController as! ContentViewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        return orderedViewControllers[nextIndex]
    }
    
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        print("orderedViewControllers.count is\(orderedViewControllers.count)" )
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = orderedViewControllers.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        print("the firstPageIndex is \(firstViewControllerIndex)")
        return firstViewControllerIndex
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if (!completed)
        {
            return
        }
        showIndexAtNavVC()
    }
    
    func showIndexAtNavVC () {
        let vc = self.viewControllers![0] as! ContentViewController
        print (vc.indexLabel.text!)
        self.navigationItem.title = "\(vc.indexNumber)"
    }
}
