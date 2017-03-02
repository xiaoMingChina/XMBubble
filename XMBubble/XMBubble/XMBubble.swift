//
//  XMBubble.swift
//  XMBubble
//
//  Created by xiaoming on 15/12/18.
//  Changed by xiaoming on 17/3/1.
//  Copyright © 2015年 小明. All rights reserved.
//

import SpriteKit
import UIKit

enum LoveDegree {
    case Normal
    case Like
    case Love
}


class XMBubble: SKSpriteNode {

    
    init() {
        let texture = SKTexture.init(image: #imageLiteral(resourceName: "Bubble"))
        let textureSize = CGSize.init(width: 80, height: 80)
        super.init(texture: texture, color: UIColor.clear, size: textureSize)
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
        let vector = CGVector.init(dx: self.randomValue() * 30 * x, dy:  self.randomValue() * 30 * y)
        return vector
    }
    
    func runActionWithChangedLoveDegree(scaleto:CGFloat) {
        let scaleAction = SKAction.scale(by: scaleto, duration: 0.2)
        self.run(scaleAction)
    }
   internal func changeLoveDegree() {
    switch self.loveDegree {
    case .Normal:
        loveDegree = .Like
        self.runActionWithChangedLoveDegree(scaleto: 1.3)
        NSLog("Normal")
    case .Like:
        NSLog("Like")
        loveDegree = .Love
        self .runActionWithChangedLoveDegree(scaleto: 1/1.3*1.6)
    case .Love:
        NSLog("Love")
        loveDegree = .Normal
        self .runActionWithChangedLoveDegree(scaleto: 1/1.6)
    }

    }
}
