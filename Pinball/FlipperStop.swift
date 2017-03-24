//
//  Flipper.swift
//  Pinball
//
//  Created by Jay Steingold on 3/23/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import Foundation
import SpriteKit

class FlipperStop:SKSpriteNode {
    
    func setUp() {
        self.physicsBody?.categoryBitMask = BodyType.flipperStop.rawValue
        self.physicsBody?.collisionBitMask = BodyType.flipper.rawValue
        self.physicsBody?.contactTestBitMask = BodyType.flipper.rawValue
        self.physicsBody?.usesPreciseCollisionDetection = true 
    }
    
}
