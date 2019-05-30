//
//  TutorialPageControl.swift
//  Color Blind
//
//  Created by qbuser on 28/06/16.
//  Copyright © 2016 Pai. All rights reserved.
//

import UIKit

class TutorialPageController: UIPageViewController, UIPageViewControllerDataSource {
    
    var pagesArray:[UIViewController]? = nil
    var tutorial1:UIViewController? = nil, tutorial2:UIViewController? = nil, tutorial3:UIViewController? = nil, tutorial4:UIViewController? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageControl()
    }
    
    fileprivate func setupPageControl() {
        self.dataSource = self
        
        self.tutorial1 = self.storyboard!.instantiateViewController(withIdentifier: "tutorialpage1")
        self.tutorial2 = self.storyboard!.instantiateViewController(withIdentifier: "tutorialpage2")
        self.tutorial3 = self.storyboard!.instantiateViewController(withIdentifier: "tutorialpage3")
        self.tutorial4 = self.storyboard!.instantiateViewController(withIdentifier: "tutorialpage4")
        
        self.pagesArray = [self.tutorial1!, self.tutorial2!, self.tutorial3!, self.tutorial4!]
        
        self.setViewControllers([self.tutorial1!], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.clear
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        switch viewController {
        case self.tutorial1!:
            return self.tutorial4!
        case self.tutorial2!:
            return self.tutorial1!
        case self.tutorial3!:
            return self.tutorial2!
        case self.tutorial4!:
            return self.tutorial3!
        default:
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        switch viewController {
        case self.tutorial1!:
            return self.tutorial2!
        case self.tutorial2!:
            return self.tutorial3!
        case self.tutorial3!:
            return self.tutorial4!
        case self.tutorial4!:
            return self.tutorial1
        default:
            return nil
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}


