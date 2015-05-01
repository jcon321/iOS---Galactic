//
//  EnemyShipManager.swift
//  Galactic
//
//  Created by Jordan Conner on 4/24/15.
//  Copyright (c) 2015 Jordan Conner. All rights reserved.
//

import SpriteKit

/*
*  Handles level creation
*  Handles level completion
*  Handles level completion labels
*  Handles Enemy Shooting
*/

class EnemyShipManager {
    
    let theParent:GameScene
    
    var enemyCount = 0
    
    var enemyShips = [EnemyShip]()
    
    // Time intervals for Shooting
    var lastUpdateTime = NSTimeInterval(0)
    var timeSinceLastAction = NSTimeInterval(0)
    var timeUntilNextAction = NSTimeInterval(4)
    
    init(theParent: GameScene) {
        self.theParent = theParent
    }
    
    func createLevel(currentLevel: Int) {
        levelLabelAction(currentLevel)
        switch currentLevel {
        case 2:
            enemyCount = 15
            for var i = 0; i < 15; i++ {
                var anEnemyShip = EnemyShip()
                anEnemyShip.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(theParent.frame.width))), y: theParent.frame.height - 150)
                theParent.addChild(anEnemyShip)
                enemyShips.append(anEnemyShip)
            }
        
        default:
            enemyCount = 10
            for var i = 0; i < 10; i++ {
                var anEnemyShip = EnemyShip()
                anEnemyShip.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(theParent.frame.width))), y: theParent.frame.height - 150)
                theParent.addChild(anEnemyShip)
                enemyShips.append(anEnemyShip)
            }
        }
    }
    
    func allEnemyDestroyed() -> Bool {
        
        var result = false;
        
        if enemyCount == 0 {
            return true
        }
        
        return result
    }
    
    func levelLabelAction(currentLevel: Int) {
        var levelLabel = SKLabelNode(fontNamed: "Arial")
        levelLabel.text = "Level \(currentLevel)"
        levelLabel.fontSize = 150
        levelLabel.position = CGPointMake(CGRectGetMidX(theParent.frame), CGRectGetHeight(theParent.frame))
        theParent.addChild(levelLabel)
        
        let actionMove = SKAction.moveTo(CGPoint(x: levelLabel.position.x, y: -100), duration: 2.5)
        let actionMoveDone = SKAction.removeFromParent()
        levelLabel.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }

    func enemyShoots(currentTime: NSTimeInterval) {
        let delta = currentTime - lastUpdateTime
        lastUpdateTime = currentTime
        timeSinceLastAction += delta
        
        if timeSinceLastAction >= timeUntilNextAction {
            
            //grab a random enemy ship that is not dead
            var foundAlive = false
            var whichShip = 0
            
            while(!foundAlive) {
                whichShip = Int(arc4random_uniform(UInt32(enemyShips.count)))
                if (!enemyShips[whichShip].dead) {
                    foundAlive = true
                }
            }
            
            enemyShips[whichShip].shoot(theParent)
            
            timeSinceLastAction = NSTimeInterval(0)
            
            timeUntilNextAction = enemyShips[whichShip].shootInterval
            
        }
        
    }
    
}