//
//  PrologScene.swift
//  arvogame
//
//  Created by Haddawi on 22/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import SpriteKit

class PrologScene: SKScene {
    
    var prologMessageLabelNode : SKLabelNode!
    let myText = Array("Quick Jump Fox Runs Over The Lazy Dog")
    var myCounter = 0
    var timer:Timer?
    
    var skipButton: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        constructBackground()
        constructPrologMessage()
        
        skipButton = (childNode(withName: "//SkipButton") as! SKSpriteNode)
    }
    
    func constructBackground() {
        let backgroundImage = SKSpriteNode(imageNamed: "dummy-intro")
        
        backgroundImage.name = "prologBackgroundImage"
        backgroundImage.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
        backgroundImage.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        backgroundImage.position = CGPoint(x: 0, y: 0)
        
        self.addChild(backgroundImage)
    }
    
    func constructPrologMessage() {
        prologMessageLabelNode = SKLabelNode(text: "")
        prologMessageLabelNode?.name = "prologMessage"
        prologMessageLabelNode?.fontName = "Helvetica"
        prologMessageLabelNode.horizontalAlignmentMode = .center
        prologMessageLabelNode?.fontSize = 36
        prologMessageLabelNode?.position = CGPoint(x: (0), y: (0 - ((self.scene?.size.height)!/3)))
        prologMessageLabelNode?.zPosition = 1
        
        self.addChild(prologMessageLabelNode)
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(PrologScene.typeLetter), userInfo: nil, repeats: true)
    }
    
    @objc func typeLetter() {
        if myCounter < myText.count {
            prologMessageLabelNode?.text = (prologMessageLabelNode?.text!)! + String(myText[myCounter])

            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(PrologScene.typeLetter), userInfo: nil, repeats: false)
        } else {
            timer?.invalidate()
        }
        myCounter += 1
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode {
            if node == skipButton {
                if let scene = SKScene(fileNamed: "HomeScene") {
                    scene.scaleMode = .aspectFill
                    view?.presentScene(scene)
                }
            }
        }
    }
}
