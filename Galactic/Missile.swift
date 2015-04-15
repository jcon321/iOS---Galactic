//
//  Missile.swift
//  Galactic
//
//  Created by Jordan Conner on 4/15/15.
//  Copyright (c) 2015 Jordan Conner. All rights reserved.
//

import SpriteKit


class Missile: SKSpriteNode {
    
    // Image names
    let missile1 = "missile1"
    
    
    init(missileVersion:Int) {
        
        switch(missileVersion) {
        case 1:
            super.init(texture: nil, color: UIColor.redColor(), size: CGSize(width: 10, height: 10))
        default:
            super.init(texture: SKTexture(imageNamed: missile1), color: UIColor.clearColor(), size: CGSize(width: 12, height: 12))
        }
        
        self.zPosition = -1
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.dynamic = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}