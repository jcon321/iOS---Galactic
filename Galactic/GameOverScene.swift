//
//  GameOverScene.swift
//  Galactic
//
//  Created by Jordan Conner on 5/1/15.
//  Copyright (c) 2015 Jordan Conner. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    init(size: CGSize, won:Bool) {
        super.init(size: size)
        
        backgroundColor = SKColor.blackColor()
        
        var message = won ? "You Won!" : "Game Over!"
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.whiteColor()
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(label)
        
        runAction(SKAction.sequence([SKAction.waitForDuration(3.0), SKAction.runBlock() {
            let reveal = SKTransition.flipHorizontalWithDuration(0.5)
            let scene = GameScene(size: size)
            scene.scaleMode = .AspectFill
            self.view?.presentScene(scene, transition:reveal)
            }
        ]))
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
