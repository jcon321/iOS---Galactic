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
    
    var missile : EnemyMissile {
        get {
            return EnemyMissile(missileVersion: missileVersion)
        }
    }
    
    init() {
        super.init(texture: nil, color: UIColor.purpleColor(), size: CGSize(width: 24, height: 24))
        self.zPosition = 0
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.categoryBitMask = GlobalConstants.enemyShipCategory
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
    
}