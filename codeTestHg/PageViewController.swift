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
    
    let colors = [UIColor.whiteColor, UIColor.purpleColor, UIColor.greenColor]
    let pageTitles = ["Hi", "✦", "◉"]
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
    //    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        view.backgroundColor = .whiteColor()
        if let firstContentVC = orderedViewControllers.first {
            setViewControllers([firstContentVC], direction: .Forward, animated: true, completion: nil)
        }
    }
    
    func newContentVC(imageObject imageObject: ImageObject) -> ContentViewController {
        
        let contentViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("contentVC") as! ContentViewController
        contentViewController.view.backgroundColor = colors[Int(arc4random_uniform(2))]()
        contentViewController.title = imageObject.name
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
            return nil
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
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    

    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = orderedViewControllers.first,
            firstViewControllerIndex = orderedViewControllers.indexOf(firstViewController) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if (!completed)
        {
            return
        }
        self.currentIndex = (self.viewControllers!.first?.view.tag)!
        print("the page index is \(self.currentIndex)")

    }
    
}
