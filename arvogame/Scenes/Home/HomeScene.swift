//
//  HomeScene.swift
//  arvogame
//
//  Created by Haddawi on 23/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import SpriteKit

class HomeScene: SKScene {
    override func didMove(to view: SKView) {
        constructBackground()
    }
    
    func constructBackground() {
        let backgroundImage = SKSpriteNode(imageNamed: "dummy-homescreen")
        backgroundImage.name = "homeScreen"
        backgroundImage.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        backgroundImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundImage.position = CGPoint(x: 0, y: 0)
        
        self.addChild(backgroundImage)
    }
}
