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
    var enemyShipSpacing : CGFloat = 0
    
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
        
        enemyShips.removeAll(keepCapacity: false)
        
        switch currentLevel {
        case 5:
            enemyCount = 11
            enemyShipSpacing = 80
        case 4:
            enemyCount = 9
            enemyShipSpacing = 100
        case 3:
            enemyCount = 7
            enemyShipSpacing = 120
        case 2:
            enemyCount = 5
            enemyShipSpacing = 180
        default:
            enemyCount = 3
            enemyShipSpacing = 240
        }
        
        for var i = 0; i < enemyCount; i++ {
            var anEnemyShip = EnemyShip()
            theParent.addChild(anEnemyShip)
            enemyShips.append(anEnemyShip)
        }
        
        placeEnemyShips()
    }
    
    func placeEnemyShips() {
        
        let row1 = self.theParent.size.height - 150
        let mid = self.theParent.size.width / 2
        
        var offsetCounter : CGFloat = 1
    
        for var i = 0; i < enemyCount; i++ {
            // Start the Enemy Ship off the map so it can fly into place, only shoot once in position
            enemyShips[i].position = CGPoint(x: mid, y: row1 + 200)
            if i == 0 {
                let actionMove = SKAction.moveTo(CGPoint(x: mid, y: row1), duration: enemyShips[i].shipSpeed)
                let thisI = i
                enemyShips[i].runAction(actionMove, completion: {self.enemyShips[thisI].inPosition = true})
            } else if i % 2 == 0 {
                let actionMove = SKAction.moveTo(CGPoint(x: mid - (enemyShipSpacing * offsetCounter), y: row1), duration: enemyShips[i].shipSpeed)
                let thisI = i
                enemyShips[i].runAction(actionMove, completion: {self.enemyShips[thisI].inPosition = true})
                offsetCounter++
            } else {
                let actionMove = SKAction.moveTo(CGPoint(x: mid + (enemyShipSpacing * offsetCounter), y: row1), duration: enemyShips[i].shipSpeed)
                let thisI = i
                enemyShips[i].runAction(actionMove, completion: {self.enemyShips[thisI].inPosition = true})
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