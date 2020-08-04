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
    var buttonNextProlog: SKSpriteNode!
    var bgImage: SKSpriteNode!
    var timer: Timer?
    var prologBacksongAudio = AVAudioPlayer()
    
    let messages = [(Array("Duh, tiap baca berita selalu tentang kebakaran lahan ... sebetulnya apa sih yang sedang terjadi di negara ini??")), (Array(" Aku harus ikut membantu nih ..."))]
    
    var prologScenes = 0
    var messageStringCounter = 0
    
    override func didMove(to view: SKView) {
        buttonSkip = (childNode(withName: "//SkipButtonText") as! SKLabelNode)
        
        setupPrologBacksongAudio()
        setupPrologMessage()
        constructDialogBox()
        prologBacksongAudio.play()
    }
    
    func setupPrologMessage() {
        switch prologScenes {
        case 0...1:
            constructBackground()
            constructPrologMessage()
            messageStringCounter = 0
        default:
            presentHomeScene()
        }
    }
    
    func constructBackground() {
        bgImage = SKSpriteNode(imageNamed: "prolog-bg-\(prologScenes)")
        bgImage.name = "prologBackgroundImage"
        bgImage.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        bgImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bgImage.position = CGPoint(x: 0, y: 0)
        bgImage.zPosition = CGFloat(prologScenes)
        
        self.addChild(bgImage)
    }
    
    func constructDialogBox() {
        let dialogBox = SKSpriteNode(imageNamed: "prolog-message-box")
        dialogBox.name = "prologDialogBox"
        dialogBox.size = CGSize(width: 746, height: 134)
        dialogBox.setScale(1.75)
        dialogBox.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        dialogBox.position = CGPoint(x: 0, y: (0 - ((self.scene?.size.height)!/3.75)))
        dialogBox.zPosition = 3
        
        buttonNextProlog = SKSpriteNode(imageNamed: "icon-triangle")
        buttonNextProlog.size = CGSize(width: 20, height: 18)
        buttonNextProlog.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        buttonNextProlog.position = CGPoint(x: 0 + ((dialogBox.size.width)/3.8), y: 0 - ((dialogBox.size.height)/7.5))
        buttonNextProlog.zPosition = 4
        
        dialogBox.addChild(buttonNextProlog)
        
        self.addChild(dialogBox)
        
    }
    
    func constructPrologMessage() {
        prologMessageLabelNode?.text = ""
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
        prologMessageLabelNode?.zPosition = 4
        
        self.addChild(prologMessageLabelNode)
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(PrologScene.typeLetter), userInfo: nil, repeats: true)
    }
    
    @objc func typeLetter() {
        if prologScenes < 2 {
            if messageStringCounter < messages[prologScenes].count {
                prologMessageLabelNode?.text = (prologMessageLabelNode?.text!)! + String(messages[prologScenes][messageStringCounter])
                timer?.invalidate()
                timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(PrologScene.typeLetter), userInfo: nil, repeats: false)
           } else {
                timer?.invalidate()
                prologScenes += 1
                setupPrologMessage()
           }
           
           messageStringCounter += 1
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKLabelNode {
            if node == buttonSkip {
                prologBacksongAudio.stop()
                presentHomeScene()
            }
        } else if let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode {
            if node == buttonNextProlog {
                prologScenes += 1
                setupPrologMessage()
            }
        }
    }
    
    func presentHomeScene() {
        if let scene = SKScene(fileNamed: "InputName") {
            scene.scaleMode = .aspectFill
            view?.presentScene(scene)
        }
    }
}
