//
//  SGPagerVC.swift
//  SGPager
//
//  Created by Shamkhal Guliyev on 28.08.2017.
//  Copyright © 2017 Shamkhal Guliyev. All rights reserved.
//

import UIKit

class SGPagerVC: UIViewController {
    
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var pager: UIPageControl!
    
    var x: CGFloat = 0
    var currentIndex = 1
    
    var viewSlide = UIView()
    var buttonOnAir = UIButton()
    var buttonPopular = UIButton()
    var buttonFollowed = UIButton()
    
    var pageVC = SGPageController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "SGPageIndex"), object: nil, queue: nil) { (notification: Notification) in
            
            let dict = notification.userInfo
            self.pager.currentPage = dict?["index"] as! Int
        }
    }
}
