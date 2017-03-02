//
//  ViewController.swift
//  XMBubble
//
//  Created by xiaoming on 15/12/17.
//  Changed by xiaoming on 17/3/1.
//  Copyright © 2015年 小明. All rights reserved.
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
        scene.scaleMode = .aspectFill
        bubbleSceneView .presentScene(scene)
    }
    
}

