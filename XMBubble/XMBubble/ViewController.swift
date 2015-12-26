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
    
    @IBOutlet weak var bubbleSceneView: SKView!
    @IBOutlet weak var settingView: UIView!
    @IBOutlet weak var explaintionView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = XMBubbleScene.init(size: bubbleSceneView.frame.size)
        bubbleSceneView.ignoresSiblingOrder = true
        scene.scaleMode = .AspectFill
        bubbleSceneView .presentScene(scene)
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

