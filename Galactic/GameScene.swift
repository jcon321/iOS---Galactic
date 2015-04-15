//
//  GameScene.swift
//  Galactic
//
//  Created by Jordan Conner on 3/30/15.
//  Copyright (c) 2015 Jordan Conner. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var background: SKSpriteNode!
    
    var spaceship: Spaceship!
    
    // Accelerometer
    var motionManager = CMMotionManager()
    var destX:CGFloat = 0.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        //self.view?.showsPhysics = true
        
        initializingScrollingBackground()
        createAndAddSpaceship()
        handleAccelerometer()
        
        createAndAddEnemyShip()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {

        // 1 - Choose one of the touches to work with
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        createAndShootMissile()
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        var action = SKAction.moveToX(destX, duration: 1)
        self.spaceship.runAction(action)
        
        handleWallFlip()
        
        self.moveBackground()
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstNode = contact.bodyA.node as! SKSpriteNode
        let secondNode = contact.bodyB.node as! SKSpriteNode
        
        if(contact.bodyA.categoryBitMask == GlobalConstants.enemyShipCategory) && (contact.bodyB.categoryBitMask == GlobalConstants.missileCategory) {
            
            // My missile hits enemy
            
            let enemyShip = firstNode as! EnemyShip
            enemyShip.explode(self)
            secondNode.removeFromParent()
            
        } else if (contact.bodyB.categoryBitMask == GlobalConstants.enemyShipCategory) && (contact.bodyA.categoryBitMask == GlobalConstants.missileCategory) {
            
            // My missile hits enemy
            
            let enemyShip = secondNode as! EnemyShip
            enemyShip.explode(self)
            firstNode.removeFromParent()
            
        } else if (contact.bodyA.categoryBitMask == GlobalConstants.spaceshipCategory) && (contact.bodyB.categoryBitMask == GlobalConstants.enemyMissileCategory) {
            
            // Enemy missile hits me
            
        } else if (contact.bodyB.categoryBitMask == GlobalConstants.spaceshipCategory) && (contact.bodyA.categoryBitMask == GlobalConstants.enemyMissileCategory) {
            
            // Enemy missile hits me
            
        }
    }
    
    func handleAccelerometer() {
        // Handle Accelerometer
        if motionManager.accelerometerAvailable == true {
            
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler:{ data, error in
                
                var currentX = self.spaceship.position.x
                
                if data.acceleration.x < 0 {
                    self.destX = currentX + CGFloat(data.acceleration.y * 2000)
                }
                else if data.acceleration.x > 0 {
                    self.destX = currentX + CGFloat(data.acceleration.y * 2000)
                }
                
            })
        }
    }
    
    func initializingScrollingBackground() {
        for var index = 0; index < 2; index++ {
            let bg = SKSpriteNode(imageNamed: "mySpaceBG")
            bg.size = CGSize(width: self.frame.width, height: self.frame.height)
            bg.position = CGPoint(x: 0, y: index * Int(bg.size.height))
            bg.anchorPoint = CGPointZero
            bg.name = "background"
            bg.zPosition = -99
            self.addChild(bg)
        }
    }
    
    func moveBackground() {
        let backgroundVelocity:CGFloat = 3.0
        self.enumerateChildNodesWithName("background", usingBlock: {(node, stop) -> Void in
            if let bg = node as? SKSpriteNode {
                bg.position = CGPoint(x: bg.position.x, y: bg.position.y - backgroundVelocity)
                
                if bg.position.y <= -bg.size.height {
                    bg.position = CGPointMake(bg.position.x, bg.position.y + bg.size.height * 2)
                }
            }
        })
    }
    
    func createAndAddSpaceship() {
        spaceship = Spaceship()
        spaceship.position = CGPointMake(frame.size.width/2, frame.size.height/5)
        self.addChild(spaceship)
    }
    
    func createAndShootMissile() {
        var missile = spaceship.missile
        missile.position = spaceship.position
        missile.physicsBody?.categoryBitMask = GlobalConstants.missileCategory
        missile.physicsBody?.contactTestBitMask = GlobalConstants.missileCategory | GlobalConstants.enemyShipCategory
        self.addChild(missile)
        
        // 3 - Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: missile.position.x, y: 1000), duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        missile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func createAndAddEnemyShip() {
        for var i = 0; i < 10; i++ {
            var anEnemyShip = EnemyShip()
            anEnemyShip.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(self.frame.width))), y: self.frame.height - 150)
            self.addChild(anEnemyShip)
        }
    }
    
    
    func handleWallFlip() {
        // When the spaceship reaches the left wall, move it to the right wall and vica versa
        
        if spaceship.position.x < -10 {
            spaceship.removeAllActions()
            var movetoRightWall = SKAction.moveToX(self.frame.width, duration: 0)
            spaceship.runAction(movetoRightWall)
        } else if spaceship.position.x > self.frame.width + 10 {
            spaceship.removeAllActions()
            var movetoLeftWall = SKAction.moveToX(0, duration: 0)
            spaceship.runAction(movetoLeftWall)
        }
    }
    
}
