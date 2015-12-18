//
//  ViewController.swift
//  XMBubble
//
//  Created by zlm on 15/12/17.
//  Copyright © 2015年 zlm. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let skView = self.view as! SKView
        let scene = XMBubbleScene.init(size: skView.bounds.size)
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        skView .presentScene(scene)
    }
    
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}

