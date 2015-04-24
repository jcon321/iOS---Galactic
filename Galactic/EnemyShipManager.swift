//
//  EnemyShipManager.swift
//  Galactic
//
//  Created by Jordan Conner on 4/24/15.
//  Copyright (c) 2015 Jordan Conner. All rights reserved.
//

import SpriteKit


class EnemyShipManager {
    
    let theParent:GameScene
    
    var enemyCount = 0
    
    init(theParent: GameScene) {
        self.theParent = theParent
    }
    
    func createLevel(currentLevel: Int) {
        levelLabelAction(currentLevel)
        switch currentLevel {
        case 1:
            enemyCount = 15
            for var i = 0; i < 15; i++ {
                var anEnemyShip = EnemyShip()
                anEnemyShip.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(theParent.frame.width))), y: theParent.frame.height - 150)
                theParent.addChild(anEnemyShip)
            }
        
        default:
            enemyCount = 10
            for var i = 0; i < 10; i++ {
                var anEnemyShip = EnemyShip()
                anEnemyShip.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(theParent.frame.width))), y: theParent.frame.height - 150)
                theParent.addChild(anEnemyShip)
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
    
}