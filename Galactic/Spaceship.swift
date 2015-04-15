//
//  Spaceship.swift
//  Galactic
//
//  Created by Jordan Conner on 4/1/15.
//  Copyright (c) 2015 Jordan Conner. All rights reserved.
//

import SpriteKit

class Spaceship: SKSpriteNode {
    
    var missileVersion = 0
    
    var missile : Missile {
        get {
            return Missile(missileVersion: missileVersion)
        }
    }
    
    init() {
        super.init(texture: SKTexture(imageNamed: "Spaceship"), color: UIColor.clearColor(), size: CGSize(width: 75, height: 75))
        self.zPosition = 0
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.categoryBitMask = GlobalConstants.spaceshipCategory
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.dynamic = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
