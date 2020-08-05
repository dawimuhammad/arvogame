//
//  HomeScene.swift
//  arvogame
//
//  Created by Haddawi on 23/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class HomeScene: SKScene {
    var buttonStart: SKSpriteNode!
    var homeBacksongAudio = AVAudioPlayer()
    var buttonStartAudio = AVAudioPlayer()
    
    override func didMove(to view: SKView) {
        constructBackground()
        constructLogo()
        
        buttonStart = (childNode(withName: "//ButtonStart") as! SKSpriteNode)
        
        setupHomesceneBacksongAudio()
        setupButtonStartAudio()
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
    
    func presentNextScene() {
        if let scene = SKScene (fileNamed: "Loading") {
            scene.scaleMode = .aspectFill
            
            let presentScene = SKAction.run {
                self.view?.presentScene(scene)
            }
            
            let presentSequence = SKAction.sequence([SKAction.wait(forDuration: 1), presentScene])
            
            run(presentSequence)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode {
            if node == buttonStart {
                buttonStartAudio.play()
                presentNextScene()
            }
        }
    }
}
