//
//  ShopCollectionViewController.swift
//  Drop
//
//  Created by Oisin Nolan on 8/10/15.
//  Copyright (c) 2015 Oisin Nolan. All rights reserved.
//

import UIKit

class ShopCollectionViewController: UICollectionViewController {
    
    var pricesArray = [String]()
    var imagesArray = [String]()
    
    override func viewDidLoad() {
        
        pricesArray = ["20","20","35","35","50","50"]
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        var image = cell.viewWithTag(1) as! UIImageView
        var priceLabel = cell.viewWithTag(2) as! UILabel
        var buyButton = cell.viewWithTag(3) as! UIButton
        
        priceLabel.text = pricesArray[indexPath.row]
        
        return cell
    }
    
}
