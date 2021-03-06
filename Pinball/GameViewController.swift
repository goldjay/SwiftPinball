//
//  GameViewController.swift
//  Pinball
//
//  Created by Jay Steingold on 3/22/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Checks to see if file exists
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
    
                
                // Present the scene
                view.presentScene(scene)
                
                let scoreNode = SKLabelNode()
                scoreNode.text = "SCORE: 0"
                scoreNode.name = "ScoreLabel"
                scoreNode.fontSize = 20
                scoreNode.position = CGPoint(x: 325, y: 641)
                scoreNode.zPosition = 1
                
                scene.addChild(scoreNode)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
