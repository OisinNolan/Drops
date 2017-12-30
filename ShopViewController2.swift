//
//  ShopViewController2.swift
//  Drop
//
//  Created by Oisin Nolan on 8/10/15.
//  Copyright (c) 2015 Oisin Nolan. All rights reserved.
//

import UIKit

class ShopViewController2: UIViewController {
    
    @IBOutlet weak var theme1View: UIView!
    @IBOutlet weak var theme2View: UIView!
    @IBOutlet weak var theme3View: UIView!
    @IBOutlet weak var theme4View: UIView!
    @IBOutlet weak var theme5View: UIView!
    @IBOutlet weak var theme6View: UIView!
    @IBOutlet weak var theme1Button: UIButton!
    @IBOutlet weak var theme2Button: UIButton!
    @IBOutlet weak var theme3Button: UIButton!
    @IBOutlet weak var theme4Button: UIButton!
    @IBOutlet weak var theme5Button: UIButton!
    @IBOutlet weak var theme6Button: UIButton!
    
    let shopVC = ShopViewController()
    let gameVC = GameViewController()

    var coinAmount = Int()
    
    var isBought1 = Bool()
    var isBought2 = Bool()
    var isBought3 = Bool()
    var isBought4 = Bool()
    var isBought5 = Bool()
    var isBought6 = Bool()
    
    var isSelected1 = Bool()
    var isSelected2 = Bool()
    var isSelected3 = Bool()
    var isSelected4 = Bool()
    var isSelected5 = Bool()
    var isSelected6 = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isBought1 = NSUserDefaults.standardUserDefaults().boolForKey("isBought12")
        isBought2 = NSUserDefaults.standardUserDefaults().boolForKey("isBought22")
        isBought3 = NSUserDefaults.standardUserDefaults().boolForKey("isBought32")
        isBought4 = NSUserDefaults.standardUserDefaults().boolForKey("isBought42")
        isBought5 = NSUserDefaults.standardUserDefaults().boolForKey("isBought52")
        isBought6 = NSUserDefaults.standardUserDefaults().boolForKey("isBought62")
        
        isSelected1 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected12")
        isSelected2 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected22")
        isSelected3 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected32")
        isSelected4 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected42")
        isSelected5 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected52")
        isSelected6 = NSUserDefaults.standardUserDefaults().boolForKey("isSelected62")
        
        coinAmount = NSUserDefaults.standardUserDefaults().integerForKey("coinAmount12")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        checkStatus()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var price = 0
    
    var counter1 = NSUserDefaults.standardUserDefaults().integerForKey("counter12")
    var counter2 = NSUserDefaults.standardUserDefaults().integerForKey("counter22")
    var counter3 = NSUserDefaults.standardUserDefaults().integerForKey("counter32")
    var counter4 = NSUserDefaults.standardUserDefaults().integerForKey("counter42")
    var counter5 = NSUserDefaults.standardUserDefaults().integerForKey("counter52")
    var counter6 = NSUserDefaults.standardUserDefaults().integerForKey("counter62")
    
    func turnPink(view: UIView) {
        view.backgroundColor = UIColor(hue: 0.8972, saturation: 0.67, brightness: 1, alpha: 1.0)
    }
    
    func turnWhite(view: UIView) {
        view.backgroundColor = UIColor.whiteColor()
    }
    
    func flashRedBlack(button: UIButton) {
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        delay(1.0) {
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
    }
    
    func flashRedPink(button: UIButton) {
        button.setTitleColor(UIColor.redColor(), forState: .Normal)
        delay(1.0) {
            button.setTitleColor(UIColor(hue: 0.8972, saturation: 0.67, brightness: 1, alpha: 1.0), forState: .Normal)
        }
    }
    
    func turnPinkButton(button: UIButton) {
        button.setTitleColor(UIColor(hue: 0.8972, saturation: 0.67, brightness: 1, alpha: 1.0), forState: .Normal)
    }
    
    func turnWhiteButton(button: UIButton) {
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    func checkStatus() {
        if isSelected1 && isBought1{
            turnPink(theme1View)
            theme1Button.setTitle("DESELECT", forState: .Normal)
            turnWhiteButton(theme1Button)
        }
        if !isSelected1 && isBought1{
            turnWhite(theme1View)
            theme1Button.setTitle("SELECT", forState: .Normal)
            turnPinkButton(theme1Button)
        }
        
        if isSelected2 && isBought2{
            turnPink(theme2View)
            theme2Button.setTitle("DESELECT", forState: .Normal)
            turnWhiteButton(theme2Button)
        }
        if !isSelected2 && isBought2{
            turnWhite(theme2View)
            theme2Button.setTitle("SELECT", forState: .Normal)
            turnPinkButton(theme2Button)
        }
        
        if isSelected3 && isBought3{
            turnPink(theme3View)
            theme3Button.setTitle("DESELECT", forState: .Normal)
            turnWhiteButton(theme3Button)
        }
        if !isSelected3 && isBought3{
            turnWhite(theme3View)
            theme3Button.setTitle("SELECT", forState: .Normal)
            turnPinkButton(theme3Button)
        }
        
        if isSelected4 && isBought4{
            turnPink(theme4View)
            theme4Button.setTitle("DESELECT", forState: .Normal)
            turnWhiteButton(theme4Button)
        }
        if !isSelected4 && isBought4{
            turnWhite(theme4View)
            theme4Button.setTitle("SELECT", forState: .Normal)
            turnPinkButton(theme4Button)
        }
        
        if isSelected5 && isBought5{
            turnPink(theme5View)
            theme5Button.setTitle("DESELECT", forState: .Normal)
            turnWhiteButton(theme5Button)
        }
        if !isSelected5 && isBought5{
            turnWhite(theme5View)
            theme5Button.setTitle("SELECT", forState: .Normal)
            turnPinkButton(theme5Button)
        }
        
        if isSelected6 && isBought6{
            turnPink(theme6View)
            theme6Button.setTitle("DESELECT", forState: .Normal)
            turnWhiteButton(theme6Button)
        }
        if !isSelected6 && isBought6{
            turnWhite(theme6View)
            theme6Button.setTitle("SELECT", forState: .Normal)
            turnPinkButton(theme6Button)
        }
        
    }
    
    @IBAction func theme1Action(sender: AnyObject) {
        
        counter1++
        NSUserDefaults.standardUserDefaults().setInteger(counter1, forKey: "counter12")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if counter1 % 2 == 0 {
            
            shopVC.checkSelected()
            
            if isBought1 && shopVC.oneSelected {
                if isSelected1{
                    //deselect
                    isSelected1 = false
                    NSUserDefaults.standardUserDefaults().setBool(isSelected1, forKey: "isSelected12")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    shopVC.oneSelected = false
                    NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    turnWhite(theme1View)
                    theme1Button.setTitle("SELECT", forState: .Normal)
                    turnPinkButton(theme1Button)
                }
                if !isSelected1 && shopVC.oneSelected {
                    //flash red
                    flashRedPink(theme1Button)
                }
            }
            
        }
        
        if counter1 % 2 != 0 {
            
            shopVC.checkSelected()
            
            if isBought1 && !shopVC.oneSelected {
                //select
                shopVC.setTheme(7)
                isSelected1 = true
                NSUserDefaults.standardUserDefaults().setBool(isSelected1, forKey: "isSelected12")
                NSUserDefaults.standardUserDefaults().synchronize()
                shopVC.oneSelected = true
                NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                NSUserDefaults.standardUserDefaults().synchronize()
                turnPink(theme1View)
                theme1Button.setTitle("DESELECT", forState: .Normal)
                turnWhiteButton(theme1Button)
                gameVC.updateGameSceneTheme()
            }
        }
        
        if !isBought1 {
            //buy theme
            if coinAmount >= price {
                //buy theme
                coinAmount -= price
                shopVC.spendMoney(price)
                NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount12")
                NSUserDefaults.standardUserDefaults().synchronize()
                isBought1 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought1, forKey: "isBought12")
                NSUserDefaults.standardUserDefaults().synchronize()
                theme1Button.setTitle("SELECT", forState: .Normal)
                turnPinkButton(theme1Button)
            }
            else {
                flashRedBlack(theme1Button)
            }
        }
        
    }
    
    @IBAction func theme2Action(sender: AnyObject) {
        
        counter2++
        NSUserDefaults.standardUserDefaults().setInteger(counter2, forKey: "counter22")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if counter2 % 2 == 0 {
            
            shopVC.checkSelected()
            
            if isBought2 && shopVC.oneSelected {
                if isSelected2 {
                    //deselect
                    isSelected2 = false
                    NSUserDefaults.standardUserDefaults().setBool(isSelected2, forKey: "isSelected22")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    shopVC.oneSelected = false
                    NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    turnWhite(theme2View)
                    theme2Button.setTitle("SELECT", forState: .Normal)
                    turnPinkButton(theme2Button)
                }
                if !isSelected2 && shopVC.oneSelected {
                    //flash red
                    flashRedPink(theme2Button)
                }
            }
            
        }
        
        if counter2 % 2 != 0 {
            
            shopVC.checkSelected()
            
            if isBought2 && !shopVC.oneSelected {
                //select
                shopVC.setTheme(8)
                isSelected2 = true
                NSUserDefaults.standardUserDefaults().setBool(isSelected2, forKey: "isSelected22")
                NSUserDefaults.standardUserDefaults().synchronize()
                shopVC.oneSelected = true
                NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                NSUserDefaults.standardUserDefaults().synchronize()
                turnPink(theme2View)
                theme2Button.setTitle("DESELECT", forState: .Normal)
                turnWhiteButton(theme2Button)
                gameVC.updateGameSceneTheme()
            }
        }
        
        if !isBought2 {
            //buy theme
            if coinAmount >= price {
                //buy theme
                coinAmount -= price
                shopVC.spendMoney(price)
                NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount12")
                NSUserDefaults.standardUserDefaults().synchronize()
                isBought2 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought2, forKey: "isBought22")
                NSUserDefaults.standardUserDefaults().synchronize()
                theme2Button.setTitle("SELECT", forState: .Normal)
                turnPinkButton(theme2Button)
            }
            else {
                flashRedBlack(theme2Button)
            }
        }
        
    }
    
    @IBAction func theme3Action(sender: AnyObject) {
        
        counter3++
        NSUserDefaults.standardUserDefaults().setInteger(counter3, forKey: "counter32")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if counter3 % 2 == 0 {
            
            shopVC.checkSelected()
            
            if isBought3 && shopVC.oneSelected {
                if isSelected3 {
                    //deselect
                    isSelected3 = false
                    NSUserDefaults.standardUserDefaults().setBool(isSelected3, forKey: "isSelected32")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    shopVC.oneSelected = false
                    NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    turnWhite(theme3View)
                    theme3Button.setTitle("SELECT", forState: .Normal)
                    turnPinkButton(theme3Button)
                }
                if !isSelected3 && shopVC.oneSelected {
                    //flash red
                    flashRedPink(theme3Button)
                }
            }
            
        }
        
        if counter3 % 2 != 0 {
            
            shopVC.checkSelected()
            
            if isBought3 && !shopVC.oneSelected {
                //select
                shopVC.setTheme(9)
                isSelected3 = true
                NSUserDefaults.standardUserDefaults().setBool(isSelected3, forKey: "isSelected32")
                NSUserDefaults.standardUserDefaults().synchronize()
                shopVC.oneSelected = true
                NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                NSUserDefaults.standardUserDefaults().synchronize()
                turnPink(theme3View)
                theme3Button.setTitle("DESELECT", forState: .Normal)
                turnWhiteButton(theme3Button)
                gameVC.updateGameSceneTheme()
            }
        }
        
        if !isBought3 {
            //buy theme
            if coinAmount >= price {
                //buy theme
                coinAmount -= price
                shopVC.spendMoney(price)
                NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount12")
                NSUserDefaults.standardUserDefaults().synchronize()
                isBought3 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought3, forKey: "isBought32")
                NSUserDefaults.standardUserDefaults().synchronize()
                theme3Button.setTitle("SELECT", forState: .Normal)
                turnPinkButton(theme3Button)
            }
            else {
                flashRedBlack(theme3Button)
            }
        }
        
    }
    
    @IBAction func theme4Action(sender: AnyObject) {
        
        counter4++
        NSUserDefaults.standardUserDefaults().setInteger(counter4, forKey: "counter42")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if counter4 % 2 == 0 {
            
            shopVC.checkSelected()
            
            if isBought4 && shopVC.oneSelected {
                if isSelected4 {
                    //deselect
                    isSelected4 = false
                    NSUserDefaults.standardUserDefaults().setBool(isSelected4, forKey: "isSelected42")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    shopVC.oneSelected = false
                    NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    turnWhite(theme4View)
                    theme4Button.setTitle("SELECT", forState: .Normal)
                    turnPinkButton(theme4Button)
                }
                if !isSelected4 && shopVC.oneSelected {
                    //flash red
                    flashRedPink(theme4Button)
                }
            }
            
        }
        
        if counter4 % 2 != 0 {
            
            shopVC.checkSelected()
            
            if isBought4 && !shopVC.oneSelected {
                //select
                shopVC.setTheme(10)
                isSelected4 = true
                NSUserDefaults.standardUserDefaults().setBool(isSelected4, forKey: "isSelected42")
                NSUserDefaults.standardUserDefaults().synchronize()
                shopVC.oneSelected = true
                NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                NSUserDefaults.standardUserDefaults().synchronize()
                turnPink(theme4View)
                theme4Button.setTitle("DESELECT", forState: .Normal)
                turnWhiteButton(theme4Button)
                gameVC.updateGameSceneTheme()
            }
        }
        
        if !isBought4 {
            //buy theme
            if coinAmount >= price {
                //buy theme
                coinAmount -= price
                shopVC.spendMoney(price)
                NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount12")
                NSUserDefaults.standardUserDefaults().synchronize()
                isBought4 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought4, forKey: "isBought42")
                NSUserDefaults.standardUserDefaults().synchronize()
                theme4Button.setTitle("SELECT", forState: .Normal)
                turnPinkButton(theme4Button)
            }
            else {
                flashRedBlack(theme4Button)
            }
        }
        
    }
    
    @IBAction func theme5Action(sender: AnyObject) {
        
        counter5++
        NSUserDefaults.standardUserDefaults().setInteger(counter5, forKey: "counter52")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if counter5 % 2 == 0 {
            
            shopVC.checkSelected()
            
            if isBought5 && shopVC.oneSelected {
                if isSelected5 {
                    //deselect
                    isSelected5 = false
                    NSUserDefaults.standardUserDefaults().setBool(isSelected5, forKey: "isSelected52")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    shopVC.oneSelected = false
                    NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    turnWhite(theme5View)
                    theme5Button.setTitle("SELECT", forState: .Normal)
                    turnPinkButton(theme5Button)
                }
                if !isSelected5 && shopVC.oneSelected {
                    //flash red
                    flashRedPink(theme5Button)
                }
            }
            
        }
        
        if counter5 % 2 != 0 {
            
            shopVC.checkSelected()
            
            if isBought5 && !shopVC.oneSelected {
                //select
                shopVC.setTheme(11)
                isSelected5 = true
                NSUserDefaults.standardUserDefaults().setBool(isSelected5, forKey: "isSelected52")
                NSUserDefaults.standardUserDefaults().synchronize()
                shopVC.oneSelected = true
                NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                NSUserDefaults.standardUserDefaults().synchronize()
                turnPink(theme5View)
                theme5Button.setTitle("DESELECT", forState: .Normal)
                turnWhiteButton(theme5Button)
                gameVC.updateGameSceneTheme()
            }
        }
        
        if !isBought5 {
            //buy theme
            if coinAmount >= price {
                //buy theme
                coinAmount -= price
                shopVC.spendMoney(price)
                NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount12")
                NSUserDefaults.standardUserDefaults().synchronize()
                isBought5 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought5, forKey: "isBought52")
                NSUserDefaults.standardUserDefaults().synchronize()
                theme5Button.setTitle("SELECT", forState: .Normal)
                turnPinkButton(theme5Button)
            }
            else {
                flashRedBlack(theme5Button)
            }
        }
        
    }
    
    @IBAction func theme6Action(sender: AnyObject) {
        
        counter6++
        NSUserDefaults.standardUserDefaults().setInteger(counter6, forKey: "counter62")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        if counter6 % 2 == 0 {
            
            shopVC.checkSelected()
            
            if isBought6 && shopVC.oneSelected {
                if isSelected6 {
                    //deselect
                    isSelected6 = false
                    NSUserDefaults.standardUserDefaults().setBool(isSelected6, forKey: "isSelected62")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    shopVC.oneSelected = false
                    NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                    NSUserDefaults.standardUserDefaults().synchronize()
                    turnWhite(theme6View)
                    theme6Button.setTitle("SELECT", forState: .Normal)
                    turnPinkButton(theme6Button)
                }
                if !isSelected6 && shopVC.oneSelected {
                    //flash red
                    flashRedPink(theme6Button)
                }
            }
            
        }
        
        if counter6 % 2 != 0 {
            
            shopVC.checkSelected()
            
            if isBought6 && !shopVC.oneSelected {
                //select
                shopVC.setTheme(12)
                isSelected6 = true
                NSUserDefaults.standardUserDefaults().setBool(isSelected6, forKey: "isSelected62")
                NSUserDefaults.standardUserDefaults().synchronize()
                shopVC.oneSelected = true
                NSUserDefaults.standardUserDefaults().setBool(shopVC.oneSelected, forKey: "oneSelected")
                NSUserDefaults.standardUserDefaults().synchronize()
                turnPink(theme6View)
                theme6Button.setTitle("DESELECT", forState: .Normal)
                turnWhiteButton(theme6Button)
                gameVC.updateGameSceneTheme()
            }
        }
        
        if !isBought6 {
            //buy theme
            if coinAmount >= price {
                //buy theme
                coinAmount -= price
                shopVC.spendMoney(price)
                NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount12")
                NSUserDefaults.standardUserDefaults().synchronize()
                isBought6 = true
                NSUserDefaults.standardUserDefaults().setBool(isBought6, forKey: "isBought62")
                NSUserDefaults.standardUserDefaults().synchronize()
                theme6Button.setTitle("SELECT", forState: .Normal)
                turnPinkButton(theme6Button)
            }
            else {
                flashRedBlack(theme6Button)
            }
        }
        
    }
    
    func delay(delayInSeconds:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delayInSeconds * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}
