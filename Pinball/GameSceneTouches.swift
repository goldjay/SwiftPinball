//
//  GameSceneTouches.swift
//  Pinball
//
//  Created by Jay Steingold on 3/22/17.
//  Copyright © 2017 Goldjay. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if(location.x < 0){
                tappedLeft()
            }else{
                tappedRight()
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if(location.x < 0){
                letGoLeft()
            }else{
                letGoRight()
            }
        }
        
    }

}
