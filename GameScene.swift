//
//  GameScene.swift
//  Drop
//
//  Created by Oisin Nolan on 8/8/15.
//  Copyright (c) 2015 Oisin Nolan. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var viewController : GameViewController!
    var gameStarted = false
    var bgImage = SKSpriteNode()

    
    var char = SKSpriteNode()
    
    let charCategory: UInt32 = 0x1 << 0
    let enemyCategory: UInt32 = 0x1 << 1
    let coinCategory: UInt32 = 0x1 << 2
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.gravity = CGVectorMake(0, -2.0)
        self.physicsWorld.contactDelegate = self
        
        charSet(viewController.charColor)
        
    }
    
    func loadBackGround(image: String) {
        bgImage.removeFromParent()
        bgImage.texture = SKTexture(imageNamed: image)
        bgImage.zPosition = 1
        bgImage.size = CGSize(width: 640, height: 1136)
        bgImage.scene?.scaleMode = SKSceneScaleMode.AspectFill
        bgImage.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        self.addChild(bgImage)
        
    }
    
    func removeBgImage() {
        bgImage.removeFromParent()
    }
    
    func setBgColor(color: UIColor) {
        backgroundColor = color
    }
    
    func charSet(color: UIColor) {
        char.removeFromParent()
        char = SKSpriteNode(imageNamed: "char")
        char.size = CGSize(width: 75, height: 75)
        char.position = CGPoint(x: frame.width / 2, y: frame.height / 1.5)
        char.zRotation = 0
        char.zPosition = 5
        char.name = "char"
        char.color = color
        char.colorBlendFactor = 1.0
        char.physicsBody = SKPhysicsBody(circleOfRadius: char.size.width / 2.5)
        char.physicsBody?.affectedByGravity = false
        char.physicsBody?.usesPreciseCollisionDetection = true
        char.physicsBody?.categoryBitMask = charCategory
        char.physicsBody?.collisionBitMask = enemyCategory | coinCategory
        char.physicsBody?.contactTestBitMask = enemyCategory | coinCategory
        char.physicsBody?.dynamic = false
        self.addChild(char)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        for touch in (touches as! Set<UITouch>) {
            let location = touch.locationInNode(self)
            
            if gameStarted {
            
                let moveAction = SKAction.moveToX(location.x, duration: 0.4)
                moveAction.timingMode = SKActionTimingMode.EaseOut
                
                let rotateLeftAction = SKAction.rotateByAngle(+0.4, duration: 0.2)
                rotateLeftAction.timingMode = SKActionTimingMode.EaseInEaseOut
                let rotateRightAction = SKAction.rotateByAngle(-0.4, duration: 0.2)
                rotateRightAction.timingMode = SKActionTimingMode.EaseInEaseOut
                
                char.runAction(moveAction)
                if location.x > char.position.x {
                    char.runAction(rotateRightAction)
                    delay(0.21){
                        self.char.runAction(rotateLeftAction)
                    }
                }
                if location.x < char.position.x {
                    char.runAction(rotateLeftAction)
                    delay(0.21){
                        self.char.runAction(rotateRightAction)
                    }
                }
            }
            
        }
    }
    
    var enemyTimer1 = NSTimer()
    var enemyTimer2 = NSTimer()
    var enemyTimer3 = NSTimer()
    var enemyTimer4 = NSTimer()
   
    var coinTimer = NSTimer()
    var coinTimer2 = NSTimer()
    var coinTimer3 = NSTimer()
    
    var timer2 = false
    var timer3 = false
    var timer4 = false
    
    func startGame() {
        
        let rotateRightAction = SKAction.rotateByAngle(-1.5707, duration: 0.9)
        rotateRightAction.timingMode = SKActionTimingMode.EaseInEaseOut
        let moveAction = SKAction.moveToY(frame.height / 4.5, duration: 0.9)
        moveAction.timingMode = SKActionTimingMode.EaseOut
        char.runAction(moveAction)
        char.runAction(rotateRightAction)
        delay(1.0) {
            self.gameStarted = true
            self.enemyTimer1 = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("enemies"), userInfo: nil, repeats: true)
            self.coinTimer = NSTimer.scheduledTimerWithTimeInterval(11.0, target: self, selector: Selector("coins"), userInfo: nil, repeats: true)
            self.coinTimer2 = NSTimer.scheduledTimerWithTimeInterval(8.0, target: self, selector: Selector("coins2"), userInfo: nil, repeats: true)
            self.coinTimer3 = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("coins3"), userInfo: nil, repeats: true)
        }
    }
    
    func checkTimers() {
        if counter > 20 && !timer2{
            enemyTimer2 = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("enemies"), userInfo: nil, repeats: true)
            timer2 = true
        }
        if counter > 40 && !timer3{
            enemyTimer3 = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("enemies"), userInfo: nil, repeats: true)
            timer3 = true
        }
        if counter > 60 && !timer4{
            enemyTimer4 = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("enemies"), userInfo: nil, repeats: true)
            timer4 = true
        }
    }
    
    var counter = 0
    
    func enemies() {
        
        counter++
        checkTimers()
        
        var enemy = SKSpriteNode(imageNamed: "drop")
        enemy.size = CGSize(width: 50, height: 50)
        enemy.position.y = frame.size.height + 20
        enemy.name = "enemy"
        enemy.color = viewController.enemyColor
        enemy.colorBlendFactor = 1.0
        enemy.zPosition = 5
        
        var randX = arc4random_uniform(UInt32(frame.size.width))
        enemy.position.x = CGFloat(randX)
        
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.width / 2)
        enemy.physicsBody?.affectedByGravity = true
        enemy.physicsBody?.usesPreciseCollisionDetection = true
        enemy.physicsBody?.categoryBitMask = enemyCategory
        enemy.physicsBody?.collisionBitMask = charCategory
        enemy.physicsBody?.contactTestBitMask = charCategory
        
        self.addChild(enemy)
        
    }
    
    func coins() {
        
        var coin = SKSpriteNode(imageNamed: "coin")
        coin.size = CGSize(width: 50, height: 50)
        coin.position.y = frame.size.height + 20
        coin.zPosition = 4
        
        var randX = arc4random_uniform(UInt32(frame.size.width))
        coin.position.x = CGFloat(randX)
        
        coin.physicsBody = SKPhysicsBody(circleOfRadius: coin.size.width / 2)
        coin.physicsBody?.affectedByGravity = true
        coin.physicsBody?.usesPreciseCollisionDetection = true
        coin.name = "coin1"
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.collisionBitMask = charCategory
        coin.physicsBody?.contactTestBitMask = charCategory
        
        self.addChild(coin)
        
    }
    
    func coins2() {
        
        var coin = SKSpriteNode(imageNamed: "coin2")
        coin.size = CGSize(width: 50, height: 50)
        coin.position.y = frame.size.height + 20
        coin.zPosition = 4
        
        var randX = arc4random_uniform(UInt32(frame.size.width))
        coin.position.x = CGFloat(randX)
        
        coin.physicsBody = SKPhysicsBody(circleOfRadius: coin.size.width / 2)
        coin.physicsBody?.affectedByGravity = true
        coin.physicsBody?.usesPreciseCollisionDetection = true
        coin.name = "coin2"
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.collisionBitMask = charCategory
        coin.physicsBody?.contactTestBitMask = charCategory
        
        self.addChild(coin)
        
    }
    
    func coins3() {
        
        var coin = SKSpriteNode(imageNamed: "coin3")
        coin.size = CGSize(width: 50, height: 50)
        coin.position.y = frame.size.height + 20
        coin.zPosition = 4
        
        var randX = arc4random_uniform(UInt32(frame.size.width))
        coin.position.x = CGFloat(randX)
        
        coin.physicsBody = SKPhysicsBody(circleOfRadius: coin.size.width / 2)
        coin.physicsBody?.affectedByGravity = true
        coin.physicsBody?.usesPreciseCollisionDetection = true
        coin.name = "coin3"
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.collisionBitMask = charCategory
        coin.physicsBody?.contactTestBitMask = charCategory
        
        self.addChild(coin)
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA != nil && contact.bodyB != nil {
            
            if contact.bodyA.node != nil && contact.bodyB.node != nil {
            
                let firstNode = contact.bodyA.node as! SKSpriteNode
                let secondNode = contact.bodyB.node as! SKSpriteNode
                
                if (contact.bodyA.categoryBitMask == enemyCategory) && (contact.bodyB.categoryBitMask == charCategory) {
                    
                    secondNode.zRotation = 0
                    enemyCollision(firstNode)
                    secondNode.zRotation = 0
                    
                }
                if (contact.bodyA.categoryBitMask == charCategory) && (contact.bodyB.categoryBitMask == enemyCategory) {
                    
                    firstNode.zRotation = 0
                    enemyCollision(secondNode)
                    firstNode.zRotation = 0
                    
                }
                
                if (contact.bodyA.categoryBitMask == coinCategory) && (contact.bodyB.categoryBitMask == charCategory) {
                    
                    coinCollision(firstNode, coinType: secondNode.name!)
                    
                }
                if (contact.bodyA.categoryBitMask == charCategory) && (contact.bodyB.categoryBitMask == coinCategory) {
                    
                    
                    coinCollision(secondNode, coinType: secondNode.name!)
                    
                }
            }
        }
    }
    
    func coinCollision(coin: SKSpriteNode, coinType: String) {
        
        coin.removeFromParent()
        viewController.coinFlash(coinType)
        
    }
    
    func enemyCollision(enemy: SKSpriteNode) {
        
        char.zRotation = 0
        self.viewController.gameOverAnimation()
        self.removeAllChildren()
        gameOver()
        
    }
    
    func gameOver() {
        
        char.zRotation = 0
        gameStarted = false
        self.removeAllChildren()
        enemyTimer1.invalidate()
        enemyTimer2.invalidate()
        enemyTimer3.invalidate()
        enemyTimer4.invalidate()
        coinTimer.invalidate()
        coinTimer2.invalidate()
        coinTimer3.invalidate()
        charSet(viewController.charColor)
        self.viewController.resetMenu()
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        
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
