//
//  GameViewController.swift
//  Drop
//
//  Created by Oisin Nolan on 8/8/15.
//  Copyright (c) 2015 Oisin Nolan. All rights reserved.
//

import UIKit
import SpriteKit
import GameKit

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            var sceneData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)!
            var archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController, GKGameCenterControllerDelegate {
    
    let scene = GameScene.unarchiveFromFile("GameScene") as? GameScene
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var gameOverView: UIView!
    @IBOutlet var bg: UIView!
    @IBOutlet weak var newCoinLabel: UILabel!
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinAmountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var shopButton: UIButton!
    @IBOutlet weak var howToPlayButton: UIButton!
    @IBOutlet weak var finalscoreTextLabel: UILabel!
    @IBOutlet weak var finalscoreLabel: UILabel!
    @IBOutlet weak var leaderboardButton: UIButton!
    @IBOutlet weak var bannerView: GADBannerView!
    
    var coinAmount = Int()
    var score = Int()
    var scoreTimer = NSTimer()
    var enemyColor = UIColor.whiteColor()
    var charColor = UIColor.whiteColor()
    var bgColor = UIColor.blackColor()
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        
        scene?.backgroundColor = UIColor.blackColor()
        checkTheme()
        
        self.interstitial = self.createAndLoadAd()
        
        gameOverView.hidden = true
        newCoinLabel.hidden = true
        scoreLabel.hidden = true
        score = 0
        
        authenticateLocalPlayer()
        loadBannerAd()
        
        coinAmount = NSUserDefaults.standardUserDefaults().integerForKey("coinAmount1")
        NSUserDefaults.standardUserDefaults().synchronize()
        coinAmountLabel.text = String(coinAmount)
        
        super.viewDidLoad()
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsNodeCount = true
        skView.showsFPS = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        scene!.viewController = self
        
        /* Set the scale mode to scale to fit the window */
        scene!.scaleMode = .AspectFill
        
        skView.presentScene(scene)
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func updateGameSceneTheme() {
        scene?.charSet(charColor)
        scene?.setBgColor(bgColor)
    }
    
    func checkTheme() {
        
        var theme = NSUserDefaults.standardUserDefaults().integerForKey("currentTheme")
        
        switch theme {
            
        case 1:
            
            charColor = UIColor(hue: 0.9528, saturation: 1, brightness: 1, alpha: 1.0)
            enemyColor = UIColor(hue: 0.9528, saturation: 1, brightness: 1, alpha: 1.0)
            bgColor = UIColor(hue: 0.9528, saturation: 1, brightness: 0.71, alpha: 1.0)
            scene?.removeBgImage()
            self.updateGameSceneTheme()
            
            break
            
        case 2:
            
            charColor = UIColor(hue: 0.7806, saturation: 0.84, brightness: 1, alpha: 1.0)
            enemyColor = UIColor(hue: 0.7806, saturation: 0.84, brightness: 1, alpha: 1.0)
            bgColor = UIColor(hue: 0.7806, saturation: 0.84, brightness: 0.55, alpha: 1.0)
            scene?.removeBgImage()
            self.updateGameSceneTheme()
            
            break
            
        case 3:
            
            charColor = UIColor(hue: 0.6833, saturation: 1, brightness: 1, alpha: 1.0)
            enemyColor = UIColor(hue: 0.6833, saturation: 1, brightness: 1, alpha: 1.0)
            bgColor = UIColor(hue: 0.6833, saturation: 1, brightness: 0.29, alpha: 1.0)
            scene?.removeBgImage()
            self.updateGameSceneTheme()
            
            break
            
        case 4:
            
            charColor = UIColor(hue: 0.5583, saturation: 1, brightness: 1, alpha: 1.0)
            enemyColor = UIColor(hue: 0.5583, saturation: 1, brightness: 1, alpha: 1.0)
            bgColor = UIColor(hue: 0.5583, saturation: 1, brightness: 0.54, alpha: 1.0)
            scene?.removeBgImage()
            self.updateGameSceneTheme()
            
            break
            
        case 5:
            
            charColor = UIColor(hue: 0.4639, saturation: 1, brightness: 1, alpha: 1.0)
            enemyColor = UIColor(hue: 0.4639, saturation: 1, brightness: 1, alpha: 1.0)
            bgColor = UIColor(hue: 0.4639, saturation: 1, brightness: 0.5, alpha: 1.0)
            scene?.removeBgImage()
            self.updateGameSceneTheme()
            
            break
            
        case 6:
            
            charColor = UIColor(hue: 0.1389, saturation: 1, brightness: 0.97, alpha: 1.0)
            enemyColor = UIColor(hue: 0.1389, saturation: 1, brightness: 0.97, alpha: 1.0)
            bgColor = UIColor(hue: 0.0917, saturation: 1, brightness: 0.73, alpha: 1.0)
            scene?.removeBgImage()
            self.updateGameSceneTheme()
            
            break
            
        case 7:
            
            if let image = UIImage(named: "bg1") {
                scene?.loadBackGround("bg1")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            break
            
        case 8:
            
            if let image = UIImage(named: "bg2") {
                scene?.loadBackGround("bg2")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            break
            
        case 9:
            
            if let image = UIImage(named: "bg3") {
                scene?.loadBackGround("bg3")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            break
            
        case 10:
            
            if let image = UIImage(named: "bg4") {
                scene?.loadBackGround("bg4")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            break
            
        case 11:
            
            if let image = UIImage(named: "bg5") {
                scene?.loadBackGround("bg5")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            break
            
        case 12:
            
            if let image = UIImage(named: "bg6") {
                scene?.loadBackGround("bg6")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            
            break
            
        case 13:
            
            if let image = UIImage(named: "bg7") {
                scene?.loadBackGround("bg7")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            
            break
            
        case 14:
            
            if let image = UIImage(named: "bg8") {
                scene?.loadBackGround("bg8")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            
            break
            
        case 15:
            
            if let image = UIImage(named: "bg9") {
                scene?.loadBackGround("bg9")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            
            break
            
        case 16:
            
            if let image = UIImage(named: "bg10") {
                scene?.loadBackGround("bg10")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            
            break
            
        case 17:
            
            if let image = UIImage(named: "bg11") {
                scene?.loadBackGround("bg11")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
            break
            
        case 18:
            
            if let image = UIImage(named: "bg12") {
                scene?.loadBackGround("bg12")
                charColor = UIColor.whiteColor()
                enemyColor = UIColor.whiteColor()
                self.updateGameSceneTheme()
            }
            
        default:
            
            bgColor = UIColor.blackColor()
            enemyColor = UIColor.whiteColor()
            charColor = UIColor.whiteColor()
            self.updateGameSceneTheme()
            
            break
            
        }
        
    }
    
    @IBAction func startButtonAction(sender: AnyObject) {
        
        checkTheme()
        scene?.startGame()
        startButton.alpha = 1.0
        logoImage.alpha = 1.0
        coinImage.alpha = 1.0
        coinAmountLabel.alpha = 1.0
        shopButton.alpha = 1.0
        howToPlayButton.alpha = 1.0
        leaderboardButton.alpha = 1.0
        scoreLabel.alpha = 0.0
        scoreLabel.hidden = false
        delay(1.0) {
            self.scoreTimer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("addScore"), userInfo: nil, repeats: true)
        }
        
        UIView.animateWithDuration(0.15, animations: {
            self.startButton.alpha = 0.0
            self.logoImage.alpha = 0.0
            self.coinImage.alpha = 0.0
            self.coinAmountLabel.alpha = 0.0
            self.shopButton.alpha = 0.0
            self.howToPlayButton.alpha = 0.0
            self.leaderboardButton.alpha = 0.0
            }, completion: nil)
        delay(0.15){
            UIView.animateWithDuration(0.15, animations: {
                self.scoreLabel.alpha = 1.0
                }, completion: nil)
        }
        
    }
    
    
    func resetMenu() {
        
        coinAmount = NSUserDefaults.standardUserDefaults().integerForKey("coinAmount1")
        NSUserDefaults.standardUserDefaults().synchronize()
        coinAmountLabel.text = String(coinAmount)
        
        startButton.alpha = 1.0
        logoImage.alpha = 1.0
        coinImage.alpha = 1.0
        coinAmountLabel.alpha = 1.0
        shopButton.alpha = 1.0
        howToPlayButton.alpha = 1.0
        leaderboardButton.alpha = 1.0
        
        checkTheme()
        
    }
    
    func addScore() {
        score++
        scoreLabel.text = String(score)
    }
    
    func coinFlash(coinType: String) {
        
        if coinType == "coin1" {
            coinAmount += 5
            NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount1")
            NSUserDefaults.standardUserDefaults().synchronize()
            newCoinLabel.text = "+5"
            newCoinLabel.textColor = UIColor(hue: 0.8639, saturation: 0.96, brightness: 0.97, alpha: 1.0)
            self.newCoinLabel.alpha = 1.0
            self.newCoinLabel.transform = CGAffineTransformScale(newCoinLabel.transform, 1, 1)
            self.newCoinLabel.transform = CGAffineTransformTranslate(self.newCoinLabel.transform, 0, 0)
            newCoinLabel.hidden = false
            UIView.animateWithDuration(1.0, animations: {
                self.newCoinLabel.transform = CGAffineTransformScale(self.newCoinLabel.transform, 1.2, 1.2)
                self.newCoinLabel.transform = CGAffineTransformTranslate(self.newCoinLabel.transform, 0, 0)
                self.newCoinLabel.alpha = 0.0
                }, completion: nil)
            delay(1.0) {
                self.newCoinLabel.hidden = true
                self.newCoinLabel.transform = CGAffineTransformScale(self.newCoinLabel.transform, 0.83, 0.83)
                self.newCoinLabel.transform = CGAffineTransformTranslate(self.newCoinLabel.transform, 0, 0)
            }
        }
        if coinType == "coin2" {
            coinAmount += 3
            NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount1")
            NSUserDefaults.standardUserDefaults().synchronize()
            newCoinLabel.text = "+3"
            newCoinLabel.textColor = UIColor(hue: 0.2556, saturation: 1, brightness: 1, alpha: 1.0)
            self.newCoinLabel.alpha = 1.0
            self.newCoinLabel.transform = CGAffineTransformScale(newCoinLabel.transform, 1, 1)
            self.newCoinLabel.transform = CGAffineTransformTranslate(self.newCoinLabel.transform, 0, 0)
            newCoinLabel.hidden = false
            UIView.animateWithDuration(1.0, animations: {
                self.newCoinLabel.transform = CGAffineTransformScale(self.newCoinLabel.transform, 1.2, 1.2)
                self.newCoinLabel.transform = CGAffineTransformTranslate(self.newCoinLabel.transform, 0, 0)
                self.newCoinLabel.alpha = 0.0
                }, completion: nil)
            delay(1.0) {
                self.newCoinLabel.hidden = true
                self.newCoinLabel.transform = CGAffineTransformScale(self.newCoinLabel.transform, 0.83, 0.83)
                self.newCoinLabel.transform = CGAffineTransformTranslate(self.newCoinLabel.transform, 0, 0)
            }
        }
        if coinType == "coin3" {
            coinAmount += 1
            NSUserDefaults.standardUserDefaults().setInteger(coinAmount, forKey: "coinAmount1")
            NSUserDefaults.standardUserDefaults().synchronize()
            newCoinLabel.text = "+1"
            newCoinLabel.textColor = UIColor(hue: 0.5, saturation: 1, brightness: 0.99, alpha: 1.0)
            self.newCoinLabel.alpha = 1.0
            self.newCoinLabel.transform = CGAffineTransformScale(newCoinLabel.transform, 1, 1)
            self.newCoinLabel.transform = CGAffineTransformTranslate(self.newCoinLabel.transform, 0, 0)
            newCoinLabel.hidden = false
            UIView.animateWithDuration(1.0, animations: {
                self.newCoinLabel.transform = CGAffineTransformScale(self.newCoinLabel.transform, 1.2, 1.2)
                self.newCoinLabel.transform = CGAffineTransformTranslate(self.newCoinLabel.transform, 0, 0)
                self.newCoinLabel.alpha = 0.0
                }, completion: nil)
            delay(1.0) {
                self.newCoinLabel.hidden = true
                self.newCoinLabel.transform = CGAffineTransformScale(self.newCoinLabel.transform, 0.83, 0.83)
                self.newCoinLabel.transform = CGAffineTransformTranslate(self.newCoinLabel.transform, 0, 0)
            }
        }
        
    }
    
    func gameOverAnimation() {
        
        checkForAd()
        finalscoreLabel.text = String(score)
        checkHighscore()
        scoreTimer.invalidate()
        gameOverView.hidden = false
        gameOverView.alpha = 1.0
        scoreLabel.alpha = 1.0
        scoreTimer.invalidate()
        UIView.animateWithDuration(1.0,
            delay: 3.0,
            options: nil,
            animations: {
                self.gameOverView.alpha = 0.0
                self.scoreLabel.alpha = 0.0
            },
            completion: nil)
        delay(4.0) {
            self.scoreLabel.text = "0"
            self.score = 0
            self.scene?.char.zRotation = 0
        }
    }
    
    func authenticateLocalPlayer(){
        
        var localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {(viewController, error) -> Void in
            
            if (viewController != nil) {
                self.presentViewController(viewController, animated: true, completion: nil)
            }
                
            else {
                println((GKLocalPlayer.localPlayer().authenticated))
            }
        }
        
    }
    
    
    var highscore = NSUserDefaults.standardUserDefaults().integerForKey("highscore1")
    
    func checkHighscore() {
        if score > highscore {
            NSUserDefaults.standardUserDefaults().setInteger(score, forKey: "highscore1")
            NSUserDefaults.standardUserDefaults().synchronize()
            saveHighscore(score)
        }
        NSUserDefaults.standardUserDefaults().integerForKey("highscore1")
    }
    
    func saveHighscore(scoreToSend:Int) {
        
        //check if user is signed in
        if GKLocalPlayer.localPlayer().authenticated {
            
            var scoreReporter = GKScore(leaderboardIdentifier: "dropsleaderboard") //leaderboard id here
            
            scoreReporter.value = Int64(scoreToSend) //score variable here (same as above)
            
            var scoreArray: [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: {(error : NSError!) -> Void in
                if error != nil {
                    println("error")
                }
            })
            
        }
        
    }
    
    @IBAction func leaderboardAction(sender: AnyObject) {
        
        showLeader()
        
    }
    
    func showLeader() {
        var vc = self.view?.window?.rootViewController
        var gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        vc?.presentViewController(gc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController!) {
        
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    var adCounter = 0
    
    func checkForAd() {
        adCounter++
        if adCounter % 3 == 0 {
            
            if self.interstitial.isReady {
                self.interstitial.presentFromRootViewController(self)
                self.interstitial = self.createAndLoadAd()
            }
            
        }
        
    }
    
    func createAndLoadAd() -> GADInterstitial {
        
        var ad = GADInterstitial(adUnitID: "ca-app-pub-7961711404023361/5869837938")
        var request = GADRequest()
        ad.loadRequest(request)
        return ad
        
    }
    
    func loadBannerAd() {
        
        self.bannerView.adUnitID = "ca-app-pub-7961711404023361/1557389530"
        self.bannerView.rootViewController = self
        var request: GADRequest = GADRequest()
        
        self.bannerView.loadRequest(request)
        
    }
    
    
    @IBAction func unwindToVC(segue: UIStoryboardSegue) {
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
