//
//  EnemyMissile.swift
//  Galactic
//
//  Created by Jordan Conner on 4/15/15.
//  Copyright (c) 2015 Jordan Conner. All rights reserved.
//


import SpriteKit


class EnemyMissile: SKSpriteNode {
    
    // Image names
    let missile1 = "enemyMissile1"
    
    
    init(missileVersion:Int) {
        
        switch(missileVersion) {
        default:
            super.init(texture: SKTexture(imageNamed: missile1), color: UIColor.clearColor(), size: CGSize(width: 8, height: 8))
        }
        
        self.zPosition = -1
        self.name = "Enemy Missile"
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.dynamic = true
        self.physicsBody?.categoryBitMask = GlobalConstants.enemyMissileCategory
        self.physicsBody?.contactTestBitMask = GlobalConstants.enemyMissileCategory | GlobalConstants.spaceshipCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}