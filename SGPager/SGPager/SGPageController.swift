//
//  SGPageController.swift
//  SGPager
//
//  Created by Shamkhal Guliyev on 28.08.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import UIKit

class SGPageController: UIPageViewController {

    var currIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollToViewController(index newIndex: Int) {
        let direction: UIPageViewControllerNavigationDirection = newIndex >= currIndex ? .forward : .reverse
        setViewControllers([orderedViewControllers[newIndex]], direction: direction, animated: true, completion: nil)
        currIndex = newIndex
    }
    
    fileprivate func scrollToViewController(_ viewController: UIViewController, direction: UIPageViewControllerNavigationDirection = .forward)
    {
        setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }
    

    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageOne"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageTwo"),
                UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "pageThree")]
    }()

}

extension SGPageController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool)
    {
        if let firstViewController = viewControllers?.first, let index = orderedViewControllers.index(of: firstViewController)
        {
            let dict = ["index" : index]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SGPageIndex"), object: nil, userInfo: dict)
        }
    }
    
}

extension SGPageController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else { return nil }
        guard orderedViewControllers.count > previousIndex else { return nil }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        guard orderedViewControllersCount != nextIndex else { return nil }
        guard orderedViewControllersCount > nextIndex else { return nil }
        
        return orderedViewControllers[nextIndex]
    }
    
}
