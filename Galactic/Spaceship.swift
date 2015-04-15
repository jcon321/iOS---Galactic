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
    
    var missile : SKSpriteNode {
        get {
            switch (missileVersion) {
            case 1:
                return SKSpriteNode(color: UIColor.redColor(), size: CGSize(width: 10, height: 10))
            default:
                var missle1 = SKSpriteNode(imageNamed: "missle1")
                missle1.size = CGSize(width: 12, height: 12)
                return missle1
            }
        }
    }
    
    init() {
        super.init(texture: SKTexture(imageNamed: "Spaceship"), color: UIColor.clearColor(), size: CGSize(width: 75, height: 75))
        self.zPosition = 0
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.dynamic = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
