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
    var buttonStart: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        constructBackground()
        constructLogo()
        
        buttonStart = (childNode(withName: "//ButtonStart") as! SKSpriteNode)
    }
    
    func constructBackground() {
        let backgroundImage = SKSpriteNode(imageNamed: "home-background")
        backgroundImage.name = "homeBackgroundImage"
        backgroundImage.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        backgroundImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundImage.position = CGPoint(x: 0, y: 0)
        backgroundImage.zPosition = 0
        
        self.addChild(backgroundImage)
    }
    
    func constructLogo() {
        let logoImage = SKSpriteNode(imageNamed: "home-logo")
        logoImage.name  = "homeLogoImage"
        logoImage.setScale(2.2)
        logoImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        logoImage.position = CGPoint(x: 0, y: (0 + (self.scene?.size.height)!/4))
        logoImage.zPosition = 1
        
        self.addChild(logoImage)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode {
            if node == buttonStart {
                // direct to scene game
                print("Start Button Touched -> to Game Scene")
            }
        }
    }
}
