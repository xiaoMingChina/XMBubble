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

var originPoint     :CGPoint?
var currentPoint    :CGPoint?
var centerPoint     :CGPoint?
var leaveVector     :CGVector?
var timer           :NSTimer?
class XMBubbleScene: SKScene {
    

    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = SKColor .whiteColor()
        self.physicsBody = SKPhysicsBody.init(edgeLoopFromRect: self.frame)
        centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        let viewHight = UInt32 (self.frame.size.height)
        let deltaWidth = UInt32((self.frame.size.width - APP_SCREEN_WIDTH) / 4)
        let n = 12
        for var a = 0; a < n; a++ {
            let bubble = XMBubble.init()
            
            let randomX = CGFloat(arc4random_uniform (deltaWidth))
            let randomY = CGFloat(arc4random_uniform (viewHight))
            var initialX :CGFloat
            if a < n / 2 {
                initialX = randomX
            } else {
                initialX = self.frame.size.width - randomX
            }
            bubble.position = CGPointMake(initialX, randomY)
            self.addChild(bubble)
        }
        self .beginAutoAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAutoAction() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector:"toCenterAction", userInfo: nil, repeats:true);
        timer!.fire()
    }
    
    func toCenterAction() {
        let childrens = self.children as NSArray
        childrens .enumerateObjectsUsingBlock({ (AnyObject, Int, Bool) -> Void in
            let bubble = AnyObject as? XMBubble
            if ((bubble? .isKindOfClass(XMBubble)) != nil) {
                let random = CGFloat(arc4random_uniform (3))
                let dx = ((centerPoint?.x)! - (bubble?.position.x)!)/random
                let dy = ((centerPoint?.y)! - (bubble?.position.y)!)/random
                let vector :CGVector = CGVectorMake(dx, dy)
                bubble?.physicsBody!.applyForce(vector)
            }
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.beginAutoAction()
        NSLog("begin")
        for touch in touches {
            let location = touch.locationInNode(self)
            let bubble =  self .nodeAtPoint(location) as? XMBubble
            if ((bubble? .isKindOfClass(XMBubble)) != nil) {
                bubble! .changeLoveDegree()
            }
            originPoint = location
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (currentPoint != nil) {
            originPoint = currentPoint
        }
        for touch in touches {
            currentPoint = touch.locationInNode(self)
        }
        if (leaveVector == nil) {
            let random = CGFloat(arc4random_uniform (5)) + 2
            leaveVector = CGVectorMake((currentPoint!.x - originPoint!.x) / random, (currentPoint!.y - originPoint!.y) / random)
        }
        if (leaveVector != nil) {
            let childrens = self.children as NSArray
            childrens .enumerateObjectsUsingBlock({ (AnyObject, Int, Bool) -> Void in
                let bubble = AnyObject as? XMBubble
                if ((bubble? .isKindOfClass(XMBubble)) != nil) {
                    bubble?.physicsBody!.applyImpulse(leaveVector!)
                }
            })
        }
        leaveVector = nil
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        timer!.fire()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        
    }
    override func touchesEstimatedPropertiesUpdated(touches: Set<NSObject>) {
        
    }
}
