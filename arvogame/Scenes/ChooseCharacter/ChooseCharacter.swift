//
//  ChooseCharacter.swift
//  arvogame
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 30/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class ChooseCharacter: SKScene {
    
    var manCharacter : SKSpriteNode!
    var womanCharacter : SKSpriteNode!
    var lanjutButton : SKSpriteNode!
    var backgorundImage : SKSpriteNode!
    var pageTitle : SKLabelNode!
    var womanLabel : SKLabelNode!
    var manLabel : SKLabelNode!
    
    var buttonLanjutAudio = AVAudioPlayer()
    
    override func didMove(to view: SKView) {
        buildCharacter()
        buildLanjutButton()
        buildPageTitle()
        buildBackground()
        setupButtonLanjutAudio()
    }
    
    func buildCharacter(){
        
        manCharacter = (childNode(withName: "manCharacter") as! SKSpriteNode)
        womanCharacter = (childNode(withName: "womanCharacter") as! SKSpriteNode)
        
        manCharacter.texture = SKTexture(imageNamed: "man-char")
        womanCharacter.texture = SKTexture(imageNamed: "woman")
        
        manCharacter.zPosition = 6
        womanCharacter.zPosition = 5
        
        manLabel = SKLabelNode(fontNamed: "PressStart2P")
        manLabel.text = "Pria"
        manLabel.fontSize = 24
        manLabel.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        manLabel.zPosition = 2
        manLabel.position = CGPoint(x: manCharacter.position.x, y: manCharacter.position.y-200)
        manLabel.horizontalAlignmentMode = .center
        
        womanLabel = SKLabelNode(fontNamed: "PressStart2P")
        womanLabel.text = "Wanita"
        womanLabel.fontSize = 24
        womanLabel.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        womanLabel.zPosition = 1
        womanLabel.position = CGPoint(x: womanCharacter.position.x, y: womanCharacter.position.y-200)
        womanLabel.horizontalAlignmentMode = .center
        
        self.addChild(manLabel)
        self.addChild(womanLabel)
        
        
    }
    
    func buildLanjutButton(){
        
        lanjutButton = (childNode(withName: "lanjut") as! SKSpriteNode)
        lanjutButton.texture = SKTexture(imageNamed: "lanjut-btn")
        lanjutButton.zPosition = 4
        
    }
    
    func buildPageTitle(){
        
        pageTitle = SKLabelNode(fontNamed: "PressStart2P")
        pageTitle.text = "PILIH RESTORATOR KAMU"
        pageTitle.fontSize = 32
        pageTitle.fontColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        pageTitle.zPosition = 3
        pageTitle.position = CGPoint(x: 0, y: manCharacter.position.y+250)
        pageTitle.horizontalAlignmentMode = .center
        
        self.addChild(pageTitle)
    }
    
    func buildBackground(){
        
        backgorundImage = SKSpriteNode(imageNamed: "char-select-bg")
        backgorundImage.zPosition = 0
        backgorundImage.size = CGSize(width: 1792, height: 875)
        backgorundImage.position = CGPoint(x: 0, y: 0)
        
        self.addChild(backgorundImage)
        
    }
    
    func presentNextScene() {
        if let scene = SKScene(fileNamed: "HomeScene") {
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
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode{
            buttonLanjutAudio.play()
            
            if node == lanjutButton {
                presentNextScene()
            } else if node == manCharacter {
                UserDefaults.standard.set(true, forKey: "man")
                manCharacter.alpha = 0.5
                womanCharacter.alpha = 1
            } else if node == womanCharacter {
                UserDefaults.standard.set(true, forKey: "woman")
                manCharacter.alpha = 1
                womanCharacter.alpha = 0.5
            }
        }
    }
}
