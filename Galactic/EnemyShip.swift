//
//  EnemyShip.swift
//  Galactic
//
//  Created by Jordan Conner on 4/15/15.
//  Copyright (c) 2015 Jordan Conner. All rights reserved.
//

import SpriteKit

class EnemyShip: SKSpriteNode {
    
    var missileVersion = 0
    
    var shootInterval = NSTimeInterval(1)
    
    var dead = false
    
    // Lower = faster
    var shipSpeed : NSTimeInterval = 1.75
    
    // In position means has the ship arrived at its final position after spawning
    var inPosition = false
    
    // Whether or not the ship is moving (doesn't count when spawning and moving into initial position)
    var isMoving = false
    
    var missile : EnemyMissile {
        get {
            return EnemyMissile(missileVersion: missileVersion)
        }
    }
    
    init() {
        super.init(texture: SKTexture(imageNamed: "Enemy1"), color: UIColor.clearColor(), size: CGSize(width: 50, height: 50))
        self.zPosition = 0
        self.name = "Enemy Ship"
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.categoryBitMask = GlobalConstants.enemyShipCategory
        self.physicsBody?.dynamic = false
        
        addBarrier()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func explode(theParent: GameScene) {
        var emitterNode = SKEmitterNode(fileNamed: "Explosion.sks")
        emitterNode.position = self.position
        theParent.addChild(emitterNode)
        emitterNode.runAction(SKAction.waitForDuration(2), completion: {emitterNode.removeFromParent()})
        self.removeFromParent()
    }
    
    func shoot(theParent: GameScene) {
        if inPosition {
            var missile = self.missile
            missile.position = self.position
            theParent.addChild(missile)
            
            // 3 - Create the actions
            let actionMove = SKAction.moveTo(CGPoint(x: missile.position.x, y: -100), duration: 2.0)
            let actionMoveDone = SKAction.removeFromParent()
            missile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
        }
    }
    
    func addBarrier() {
        var barrier = SKEmitterNode(fileNamed: "Barrier.sks")
        self.addChild(barrier)
    }
    
    func removeBarrier() {
        self.childNodeWithName("barrier")?.removeFromParent()
    }
    
}