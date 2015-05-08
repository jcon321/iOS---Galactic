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
    
    init(theParent: GameScene) {
        super.init(texture: SKTexture(imageNamed: "Spaceship"), color: UIColor.clearColor(), size: CGSize(width: 75, height: 75))
        self.zPosition = 0
        self.name = "Spaceship"
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.size.width/2)
        self.physicsBody?.categoryBitMask = GlobalConstants.spaceshipCategory
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.dynamic = false
        self.position = CGPointMake(theParent.frame.size.width/2, theParent.frame.size.height/5)
        theParent.addChild(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shoot(theParent: GameScene) {
        var missile = self.missile
        missile.position = CGPoint(x: self.position.x, y: self.position.y+10)
        theParent.addChild(missile)
        
        // 3 - Create the actions
        let actionMove = SKAction.moveTo(CGPoint(x: missile.position.x, y: 1000), duration: 2.0)
        let actionMoveDone = SKAction.removeFromParent()
        missile.runAction(SKAction.sequence([actionMove, actionMoveDone]))
    }
    
    func explode(theParent: GameScene) {
        var emitterNode = SKEmitterNode(fileNamed: "SpaceshipExplosion.sks")
        emitterNode.position = self.position
        theParent.addChild(emitterNode)
        emitterNode.runAction(SKAction.waitForDuration(1.5), completion: {emitterNode.removeFromParent()})
        
        theParent.stopBackgroundMusic()
        
        // Transition to GameOverScene
        theParent.runAction(SKAction.sequence([SKAction.waitForDuration(2.0), SKAction.runBlock() {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameOverScene(size: theParent.size, won: false)
            theParent.view?.presentScene(scene, transition:reveal)
            }
        ]))
    }
    
}
