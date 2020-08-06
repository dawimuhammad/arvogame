//
//  InputName.swift
//  arvogame
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 29/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class InputName: SKScene {
    var pageTitle : SKLabelNode!
    var buttonLanjut : SKSpriteNode!
    var textField : TextField!
    var backgroundScene : SKSpriteNode!
    var buttonStartAudio = AVAudioPlayer()
    
    override func didMove(to view: SKView) {
        buildTextField()
        buildPageTitle()
        buildBackgroundScene()
        setupButtonStartAudio()
        
        buttonLanjut? = (childNode(withName: "buttonLanjut") as! SKSpriteNode)
        buttonLanjut?.zPosition = 2
    }
    
    func buildPageTitle() {
        pageTitle = SKLabelNode(fontNamed: "PressStart2P")
        pageTitle?.text = "NAMA KAMU"
        pageTitle?.position = CGPoint(x: 0, y: 250)
        pageTitle?.fontSize = 70
        pageTitle?.zPosition = 3
        pageTitle?.fontColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        self.addChild(pageTitle!)
    }
    
    func buildBackgroundScene() {
        backgroundScene = SKSpriteNode(imageNamed: "name-input-bg")
        backgroundScene.position = CGPoint(x: 0, y: 0)
        backgroundScene.zPosition = 0
        backgroundScene.size = CGSize(width: 1792, height: 875)
        
        self.addChild(backgroundScene)
    }
    
    
    func buildTextField() {
        let textFieldFrame = CGRect(x: 300, y: 180, width: 300, height: 70)
        textField = TextField(frame: textFieldFrame)
        textField.textAlignment = .center
        textField.background = #imageLiteral(resourceName: "box-name")
        textField.textColor = .black
        textField.placeholder = "Masukan Nama Kamu.."
        textField.font = UIFont(name: "PressStart2P", size: 12)
        
        self.view?.addSubview(textField)
    }
    
    
    func presentNextScene() {
        if let scene = SKScene (fileNamed: "ChooseCharacter") {
            scene.scaleMode = .aspectFill
            
            let presentScene = SKAction.run {
                self.view?.presentScene(scene)
            }
            
            let presentSequence = SKAction.sequence([SKAction.wait(forDuration: 1), presentScene])
            
            run(presentSequence)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch  = touches.first else { return }
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode {
            if node == buttonLanjut {
                buttonStartAudio.play()
                UserDefaults.standard.set(textField.text, forKey: "characterName")
                self.textField.removeFromSuperview()
                presentNextScene()
            } else {
                self.view?.endEditing(true)
            }
        }
    }

}
