//
//  XMBubbleScene.swift
//  XMBubble
//
//  Created by xiaoming on 15/12/17.
//  Changed by xiaoming on 17/3/1.
//  Copyright © 2015年 小明. All rights reserved.
//

import UIKit
import Foundation
import SpriteKit

public let APP_SCREEN_WIDTH = UIScreen.main.bounds.size.width
public let APP_SCREEN_HEIGHT = UIScreen.main.bounds.size.height

var originPoint     :CGPoint?
var currentPoint    :CGPoint?
var centerPoint     :CGPoint?
var leaveVector     :CGVector?
var timer           :Timer?
class XMBubbleScene: SKScene {
    

    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = SKColor.white
        self.physicsBody = SKPhysicsBody.init(edgeLoopFrom: self.frame)
        centerPoint = CGPoint.init(x: self.frame.size.width/2, y: self.frame.size.height/2)
        
        let viewHight = UInt32 (self.frame.size.height)
        let deltaWidth = UInt32((self.frame.size.width - APP_SCREEN_WIDTH) / 4)
        let n = 12
        
        for a in 0 ..< n {
            let bubble = XMBubble.init()
            
            let randomX = CGFloat(arc4random_uniform (deltaWidth))
            let randomY = CGFloat(arc4random_uniform (viewHight))
            var initialX :CGFloat
            if a < n / 2 {
                initialX = randomX
            } else {
                initialX = self.frame.size.width - randomX
            }
            bubble.position = CGPoint.init(x: initialX, y: randomY)
            self.addChild(bubble)
        }
        self .beginAutoAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func beginAutoAction() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(XMBubbleScene.toCenterAction), userInfo: nil, repeats: true)
        
        timer!.fire()
    }
    
    func toCenterAction() {
        let childrens = self.children as NSArray
        childrens .enumerateObjects({ (AnyObject, Int, Bool) -> Void in
            let bubble = AnyObject as? XMBubble
            
            if ((bubble?.isKind(of: XMBubble.classForCoder())) != nil) {
                let random = CGFloat(arc4random_uniform (3))
                let dx = ((centerPoint?.x)! - (bubble?.position.x)!)/random
                let dy = ((centerPoint?.y)! - (bubble?.position.y)!)/random
                let vector :CGVector = CGVector.init(dx: dx, dy: dy)
                bubble?.physicsBody!.applyForce(vector)
            }
            
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.beginAutoAction()
        NSLog("begin")
        for touch in touches {
            let location  = touch.location(in: self)
           
            originPoint = location
            
            guard self.nodes(at: location).count > 0 else {
                
                return
            }
            
            if let bubble = self.nodes(at: location)[0] as? XMBubble {
                bubble .changeLoveDegree()
            }
            
//            let bubble =  self .nodeAtPoint(location) as? XMBubble
            
//            if ((bubble?.isKind(of: XMBubble.classForCoder())) != nil) {
//                bubble! .changeLoveDegree()
//            }
            
        }
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        self.beginAutoAction()
//        NSLog("begin")
//        for touch in touches {
//            let location = touch.locationInNode(self)
//            let bubble =  self .nodeAtPoint(location) as? XMBubble
//            if ((bubble? .isKindOfClass(XMBubble)) != nil) {
//                bubble! .changeLoveDegree()
//            }
//            originPoint = location
//        }
//    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (currentPoint != nil) {
            originPoint = currentPoint
        }
        for touch in touches {
            currentPoint = touch.location(in: self)
        }
        if (leaveVector == nil) {
            let random = CGFloat(arc4random_uniform (5)) + 2
            leaveVector = CGVector.init(dx: (currentPoint!.x - originPoint!.x) / random, dy: (currentPoint!.y - originPoint!.y) / random)
        }
        if (leaveVector != nil) {
            let childrens = self.children as NSArray
            childrens .enumerateObjects({ (AnyObject, Int, Bool) -> Void in
                let bubble = AnyObject as? XMBubble
                if ((bubble?.isKind(of: XMBubble.classForCoder())) != nil) {
                    bubble?.physicsBody!.applyImpulse(leaveVector!)
                }
            })
        }
        leaveVector = nil
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer!.fire()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }

}
