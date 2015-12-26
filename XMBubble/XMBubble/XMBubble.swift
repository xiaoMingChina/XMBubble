//
//  XMBubble.swift
//  XMBubble
//
//  Created by zlm on 15/12/18.
//  Copyright © 2015年 zlm. All rights reserved.
//

import SpriteKit

enum LoveDegree {
    case Normal
    case Like
    case Love
}


class XMBubble: SKSpriteNode {

    
    init() {
        
        let texture = SKTexture(imageNamed: "Bubble")
        let textureSize = CGSizeMake(80, 80)
        super.init(texture: texture, color: UIColor.clearColor(), size: textureSize )
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: self.size.width / 2 + 1)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.applyImpulse(self.randomVector())
        
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    var loveDegree : LoveDegree = LoveDegree.Normal

    func randomValue() -> CGFloat{
        let a = CGFloat(arc4random_uniform(101))
        let b = CGFloat(a / 100)
        return b
    }
    
    func randomVector() -> CGVector {
        //力的矢量方向为 x:-30~+30  y:-30~+30
        let x: CGFloat = self.randomValue() >= 0.5 ? 1.0 : -1.0
        let y: CGFloat = self.randomValue() >= 0.5 ? 1.0 : -1.0
        let vector = CGVectorMake(self.randomValue() * 30 * x, self.randomValue() * 30 * y)
        return vector
    }
    
    func runActionWithChangedLoveDegree(scaleto:CGFloat) {
        let scaleAction = SKAction .scaleTo(scaleto, duration: 0.2)
        self .runAction(scaleAction)
    }
   internal func changeLoveDegree() {
    switch self.loveDegree {
    case .Normal:
        loveDegree = .Like
        self .runActionWithChangedLoveDegree(1.3)
        NSLog("Normal")
    case .Like:
        NSLog("Like")
        loveDegree = .Love
        self .runActionWithChangedLoveDegree(1.6)
    case .Love:
        NSLog("Love")
        loveDegree = .Normal
        self .runActionWithChangedLoveDegree(1)
    }

    }
}
