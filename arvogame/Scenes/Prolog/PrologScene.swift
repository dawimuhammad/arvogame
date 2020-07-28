//
//  PrologScene.swift
//  arvogame
//
//  Created by Haddawi on 22/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import SpriteKit
import AVFoundation

class PrologScene: SKScene {
    
    var prologMessageLabelNode : SKLabelNode!
    var buttonSkip: SKLabelNode!
    
    let message = Array("Duh, tiap baca berita selalu tentang kebakaran lahan ... sebetulnya apa sih yang sedang terjadi di negara ini??")
    
    var myCounter = 0
    var timer: Timer?
    
    var prologBacksongAudio = AVAudioPlayer()
    
    override func didMove(to view: SKView) {
        setupPrologBacksongAudio()
        constructBackground()
        constructDialogBox()
        constructPrologMessage()
        
        prologBacksongAudio.play()
        
        buttonSkip = (childNode(withName: "//SkipButtonText") as! SKLabelNode)
    }
    
    func constructBackground() {
        let backgroundImage = SKSpriteNode(imageNamed: "prolog-bg-1")
        
        backgroundImage.name = "prologBackgroundImage"
        backgroundImage.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        backgroundImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundImage.position = CGPoint(x: 0, y: 0)
        backgroundImage.zPosition = 0
        
        self.addChild(backgroundImage)
    }
    
    func constructDialogBox() {
        let dialogBox = SKSpriteNode(imageNamed: "prolog-message-box")
        
        dialogBox.name = "prologDialogBox"
        dialogBox.size = CGSize(width: 746, height: 134)
        dialogBox.setScale(1.75)
        dialogBox.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        dialogBox.position = CGPoint(x: 0, y: (0 - ((self.scene?.size.height)!/3.75)))
        dialogBox.zPosition = 1
        
        self.addChild(dialogBox)
    }
    
    func constructPrologMessage() {
        prologMessageLabelNode = SKLabelNode(text: "")
        prologMessageLabelNode?.name = "prologMessage"
        prologMessageLabelNode?.fontName = "PressStart2P"
        prologMessageLabelNode?.horizontalAlignmentMode = .center
        prologMessageLabelNode?.verticalAlignmentMode = .top
        prologMessageLabelNode?.fontSize = 23
        prologMessageLabelNode.fontColor = .black
        prologMessageLabelNode?.preferredMaxLayoutWidth = 850
        prologMessageLabelNode?.numberOfLines = 4
        prologMessageLabelNode?.position = CGPoint(x: 35, y: (0 - ((self.scene?.size.height)!/4.75)))
        prologMessageLabelNode?.zPosition = 2
        
        self.addChild(prologMessageLabelNode)
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(PrologScene.typeLetter), userInfo: nil, repeats: true)
    }
    
    @objc func typeLetter() {
        if myCounter < message.count {
            prologMessageLabelNode?.text = (prologMessageLabelNode?.text!)! + String(message[myCounter])

            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(PrologScene.typeLetter), userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
            
            if let scene = SKScene(fileNamed: "PrologScene2") {
                scene.scaleMode = .aspectFill
                view?.presentScene(scene)
            }
        }
        
        myCounter += 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKLabelNode {
            if node == buttonSkip {
                if let scene = SKScene(fileNamed: "HomeScene") {
                    prologBacksongAudio.stop()
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene)
                }
            }
        }
    }
}
