//
//  Flipper.swift
//  Pinball
//
//  Created by Jay Steingold on 3/23/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import Foundation
import SpriteKit

class Ball:SKSpriteNode {
    
    func setUp() {
        self.physicsBody?.categoryBitMask = BodyType.ball.rawValue
        self.physicsBody?.collisionBitMask = BodyType.flipper.rawValue | BodyType.ball.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.flipper.rawValue | BodyType.ball.rawValue //Maybe remove
        self.physicsBody?.usesPreciseCollisionDetection = true 
    }
    
}
