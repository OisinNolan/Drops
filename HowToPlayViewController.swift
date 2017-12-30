
//
//  HowToPlayViewController.swift
//  Drop
//
//  Created by Oisin Nolan on 8/9/15.
//  Copyright (c) 2015 Oisin Nolan. All rights reserved.
//

import UIKit
import GoogleMobileAds

class HowToPlayViewController: UIViewController {
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBannerAd()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadBannerAd() {
     
        self.bannerView.adUnitID = "ca-app-pub-7961711404023361/4371255134"
        self.bannerView.rootViewController = self
        var request: GADRequest = GADRequest()
        
        self.bannerView.loadRequest(request)
        
    }
    
    
}
