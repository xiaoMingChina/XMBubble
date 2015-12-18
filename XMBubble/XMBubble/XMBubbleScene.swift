//
//  XMBubbleScene.swift
//  XMBubble
//
//  Created by zlm on 15/12/17.
//  Copyright © 2015年 zlm. All rights reserved.
//

import SpriteKit

public let APP_SCREEN_WIDTH  = UIScreen.mainScreen().bounds.size.width
public let APP_SCREEN_HEIGHT = UIScreen.mainScreen().bounds.size.height

class XMBubbleScene: SKScene {
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = SKColor .whiteColor()
        self.physicsBody = SKPhysicsBody.init(edgeLoopFromRect: self.frame)
        
        for var a = 0; a < 3; a++ {
            let bubble = XMBubble.init()
            let randomX = CGFloat(arc4random_uniform (UInt32(APP_SCREEN_WIDTH)))
            let randomY = CGFloat(arc4random_uniform (UInt32(APP_SCREEN_HEIGHT)))

            bubble.position = CGPointMake(randomX, randomY)
            self.addChild(bubble)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
