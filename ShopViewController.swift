//
//  ShopViewController.swift
//  Drop
//
//  Created by Oisin Nolan on 8/9/15.
//  Copyright (c) 2015 Oisin Nolan. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController{
    
    let gameVC = GameViewController()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var coinAmountLabel: UIBarButtonItem!
    
    var coinAmount = Int()
    var oneSelected = NSUserDefaults.standardUserDefaults().boolForKey("oneSelected")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinAmount = NSUserDefaults.standardUserDefaults().integerForKey("coinAmount1")
        NSUserDefaults.standardUserDefaults().synchronize()
        coinAmountLabel.title = String(coinAmount) + " coins"
        
        
        let vc1 = ShopViewController1(nibName: "ShopViewController1", bundle: nil)
        
        self.addChildViewController(vc1)
        self.scrollView.addSubview(vc1.view)
        vc1.didMoveToParentViewController(self)
        
        let vc2 = ShopViewController2(nibName: "ShopViewController2", bundle: nil)
        
        var frame1 = vc1.view.frame
        frame1.origin.x = self.view.frame.size.width
        vc2.view.frame = frame1
        
        self.addChildViewController(vc2)
        self.scrollView.addSubview(vc2.view)
        vc2.didMoveToParentViewController(self)
        
        let vc3 = ShopViewController3(nibName: "ShopViewController3", bundle: nil)
        
        var frame2 = vc3.view.frame
        frame2.origin.x = self.view.frame.size.width * 2
        vc3.view.frame = frame2
        
        self.addChildViewController(vc3)
        self.scrollView.addSubview(vc3.view)
        vc3.didMoveToParentViewController(self)
        
        self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 3, self.view.frame.size.height - 66)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func checkSelected(){
        var selected = NSUserDefaults.standardUserDefaults().boolForKey("oneSelected")
        if selected {
            oneSelected = true
            NSUserDefaults.standardUserDefaults().setBool(oneSelected, forKey: "oneSelected")
            NSUserDefaults.standardUserDefaults().synchronize()
        } else {
            oneSelected = false
            NSUserDefaults.standardUserDefaults().setBool(oneSelected, forKey: "oneSelected")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func spendMoney(money: Int) {
        if money > 0 {
            coinAmountLabel.title = String(money)
        }
    }
    
    func setTheme(theme: Int) {
        NSUserDefaults.standardUserDefaults().setInteger(theme, forKey: "currentTheme")
        gameVC.checkTheme()
        NSLog("checkTheme()")
    }
    
}