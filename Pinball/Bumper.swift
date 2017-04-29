//
//  Bumper.swift
//  Pinball
//
//  Created by Jay Steingold on 4/9/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import Foundation
import SpriteKit

class Bumper: SKSpriteNode {
    var isActive: Bool = false
    var originalColor: UIColor = UIColor.red //Starting color of bumper
    
    func setUp() {
        print("FOUND BUMPER")
        
        self.physicsBody?.categoryBitMask = BodyType.bumper.rawValue
        self.physicsBody?.collisionBitMask = BodyType.ball.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.ball.rawValue
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.restitution = 1 // bounciness
        self.originalColor = self.color
        
    }
    
    func activate() {
        isActive = true
    }
    
    func deactivate() {
        isActive = false
    }
    
    func activateColor(sender: SKSpriteNode, color: UIColor){
        var changeColor = color
        if(isActive){
            changeColor = self.originalColor
        } else {
            changeColor = color
        }
        
        UIView.animate(withDuration: 0.4, animations: {
            sender.color = changeColor
        }, completion: nil)
    }
    
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
}
