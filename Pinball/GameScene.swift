//
//  GameScene.swift
//  Pinball
//
//  Created by Jay Steingold on 3/22/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import SpriteKit
import GameplayKit

enum BodyType:UInt32 {
    case flipper = 1
    case ball = 2
    case bumper = 4
    case flipperStop = 8
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var sceneWidth: CGFloat = 0
    var sceneHeight: CGFloat = 0
    
    let tapLeft = UITapGestureRecognizer()
    let tapRight = UITapGestureRecognizer()
    
    var mainBall:Ball = Ball()
    
    var score: Int = 0 {
        didSet {
            var node = self.childNode(withName: "ScoreLabel") as? SKLabelNode
            node?.text = "Score: \(score)"
        }
    }
    
    
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        sceneWidth = self.frame.width // DO NOT NEED
        sceneHeight = self.frame.height // DO NOT NEED
        
        setUpChildren()
    }
    
    func setUpChildren() {
        
        //Go through all children in scene
        for node in self.children {
            if let flipper:Flipper = node as? Flipper {
                flipper.setUp()
            }
            else if let flipperStopper:FlipperStop = node as? FlipperStop {
                flipperStopper.setUp()
            }
            else if let someBall:Ball = node as? Ball {
                someBall.setUp()
                
                if(someBall.name == "MainBall"){
                    mainBall = someBall 
                }
            } else if let someBumper: Bumper = node as? Bumper {
                someBumper.setUp()
            
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        for node in self.children {
            if let someFlipper:Flipper = node as? Flipper {
                someFlipper.update()
            } else if let ball:Ball = node as? Ball {
                for childNode in ball.children {
                    childNode.zRotation = -ball.zRotation
                }
            }
        }
    
        // RESETS ball if going below
        if(mainBall.position.y < -660){
            mainBall.position.y = 500
            mainBall.position.x = -30
            mainBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        }
    }
    
    func tappedLeft() {
        print("Tapped left")
        
        for node in self.children {
            if(node.name == "FlipperLeft") {
                if let flipper:Flipper = node as? Flipper {
                    flipper.flip()
                }
            }
        }
        
    }
    
    func tappedRight() {
        print("Tapped right")
        for node in self.children {
            if(node.name == "FlipperRight") {
                if let flipper:Flipper = node as? Flipper {
                    flipper.flip()
                }
            }
        }
    }
    
    func letGoLeft() {
        print("let go left")
        for node in self.children {
            if(node.name == "FlipperLeft") {
                if let flipper:Flipper = node as? Flipper {
                    flipper.lower()
                }
            }
        }
        
    }
    
    func letGoRight() {
        print("let go right")
        for node in self.children {
            if(node.name == "FlipperRight") {
                if let flipper:Flipper = node as? Flipper {
                    flipper.lower()
                }
            }
        }
    }
    
    // Contact handling for flipper and stop
    func didBegin(_ contact: SKPhysicsContact) {
        
        print(contact.bodyA.categoryBitMask)
        print(contact.bodyB.categoryBitMask)
        
        // change to detect degrees of the flipper?
        
        //Flipper to FlipperStop
        if(contact.bodyA.categoryBitMask == BodyType.flipper.rawValue && contact.bodyB.categoryBitMask == BodyType.flipperStop.rawValue){
            print("FLIP STOP")
            
            if let someFlipper: Flipper = contact.bodyA.node as? Flipper {
                someFlipper.lockFlipperUp()
            }
            
        } else if(contact.bodyA.categoryBitMask == BodyType.flipperStop.rawValue && contact.bodyB.categoryBitMask == BodyType.flipper.rawValue) {
            
            print("FLIP STOP")
            
            if let someFlipper: Flipper = contact.bodyB.node as? Flipper {
                someFlipper.lockFlipperUp()
            }
        }
        // Ball to bumper
        else if(contact.bodyA.categoryBitMask == BodyType.bumper.rawValue && contact.bodyB.categoryBitMask == BodyType.ball.rawValue){
            print("BUMPER CONTACT A")
            
            if let someBumper: Bumper = contact.bodyA.node as? Bumper {
                someBumper.activateColor(sender: someBumper, color: UIColor.black)
                someBumper.isActive = !someBumper.isActive
                score += 1
            }
        } else if(contact.bodyA.categoryBitMask == BodyType.ball.rawValue && contact.bodyB.categoryBitMask == BodyType.bumper.rawValue){
            print("BUMPER CONTACT B")
            
            if let someBumper: Bumper = contact.bodyA.node as? Bumper {
                someBumper.activateColor(sender: someBumper, color: UIColor.black)
                someBumper.isActive = !someBumper.isActive
                score += 1
            }
        }
        else {
            print("UNKNOWN CONTACT!!")
        }
    }
    
    func updateScore() {
        
    }

    
}
