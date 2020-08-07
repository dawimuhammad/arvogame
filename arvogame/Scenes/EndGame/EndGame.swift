//
//  EndGame.swift
//  arvogame
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 05/08/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import UIKit
import SpriteKit
import AVFoundation

class EndGame: SKScene {
    
    var caseGameWin : Bool = true
    var collectibleItem = 0
    var gameTimeInSecs = 0
    
    var titleLabel : SKLabelNode!
    var kotakHartaKarun : SKSpriteNode!
    var bintang01 : SKSpriteNode!
    var bintang02 : SKSpriteNode!
    var bintang03 : SKSpriteNode!
    var foto : SKSpriteNode!
    var jumlahFoto : SKLabelNode!
    var waktu : SKSpriteNode!
    var totalWaktu : SKLabelNode!
    var button01 : SKSpriteNode!
    var button02 : SKSpriteNode!
    var statusKotak : SKLabelNode!
    var backgroundScreen : SKSpriteNode!
    var winAudio = AVAudioPlayer()
    var loseAudio = AVAudioPlayer()
    
    override func didMove(to view: SKView) {
        
        if UserDefaults.standard.bool(forKey: "gameIsSuccess") == true {
            caseGameWin = true
        } else{
            caseGameWin = false
        }
        
        collectibleItem = UserDefaults.standard.integer(forKey: "collectibleItem")
        gameTimeInSecs = UserDefaults.standard.integer(forKey: "gameTimeInSecs")
        
        buildTitle()
        buildButton()
        buildFotoText()
        buildBackground()
        buildStatusKotak()
        buildStar()
        buidlWaktuText()
        setupAudio()
    }
    
    func buildTitle() {
        
        titleLabel = (childNode(withName: "judul") as! SKLabelNode)
        titleLabel.fontName = "PressStart2P"
        titleLabel.fontSize = 70
        titleLabel.zPosition = 3
        titleLabel.fontColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
        if UserDefaults.standard.bool(forKey: "gameIsSuccess") == true {
            titleLabel.text = "MISI SELESAI"
        } else{
            titleLabel.text = "MISI GAGAL"
        }
    }
    
    func setupAudio() {
        setupWinAudio()
        setupLoseAudio()
        
        if caseGameWin {
            winAudio.play()
        } else if !caseGameWin {
            loseAudio.play()
        }
    }
    
    func buildStar () {
        
        bintang01 = (childNode(withName: "bintang01") as! SKSpriteNode)
        bintang02 = (childNode(withName: "bintang02") as! SKSpriteNode)
        bintang03 = (childNode(withName: "bintang03") as! SKSpriteNode)
        
        if UserDefaults.standard.bool(forKey: "gameIsSuccess") == true {
            
            bintang01.texture = SKTexture(imageNamed: "stars")
            bintang02.texture = SKTexture(imageNamed: "stars")
            bintang03.texture = SKTexture(imageNamed: "stars")
            
        } else{
            
            bintang01.texture = SKTexture(imageNamed: "empty-stars")
            bintang02.texture = SKTexture(imageNamed: "empty-stars")
            bintang03.texture = SKTexture(imageNamed: "empty-stars")
        }
    }
    
    func buildButton(){
        
        button01 = (childNode(withName: "button01") as! SKSpriteNode)
        button02 = (childNode(withName: "button02") as! SKSpriteNode)
        
        if UserDefaults.standard.bool(forKey: "gameIsSuccess") == true {
            
            button02.texture = SKTexture(imageNamed: "lanjut")
        } else {
             button02.texture = SKTexture(imageNamed: "ulangi")
        }
    }
    
    func buildFotoText() {
        jumlahFoto = (childNode(withName: "jumlahFoto") as! SKLabelNode)
        jumlahFoto.text = "\(collectibleItem) / 4"
        jumlahFoto.fontName = "PressStart2P"
        jumlahFoto.fontSize = 30
        jumlahFoto.zPosition = 3
        jumlahFoto.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func buidlWaktuText() {
        totalWaktu = (childNode(withName: "jumlahWaktu") as! SKLabelNode)
        totalWaktu.text = "\(gameTimeInSecs) detik"
        totalWaktu.fontName = "PressStart2P"
        totalWaktu.fontSize = 30
        totalWaktu.zPosition = 3
        totalWaktu.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func buildStatusKotak() {
        statusKotak = (childNode(withName: "statusKotak") as! SKLabelNode)
        statusKotak.fontName = "PressStart2P"
        statusKotak.fontSize = 20
        statusKotak.zPosition = 3
        statusKotak.fontColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        if UserDefaults.standard.bool(forKey: "gameIsSuccess") == true {
            statusKotak.text = "SEMPURNA"
        } else{
            statusKotak.text = "COBA LAGI"
        }
    }
    
    func buildBackground() {
        backgroundScreen = SKSpriteNode(imageNamed: "end-bg")
        backgroundScreen.position = CGPoint(x: 0, y: 0)
        backgroundScreen.zPosition = 0
        backgroundScreen.size = CGSize(width: 1792, height: 875)
        
        self.addChild(backgroundScreen)
    }
    
    func presentHomeScene() {
        if let scene = SKScene (fileNamed: "HomeScene") {
            scene.scaleMode = .aspectFill
            
            let presentScene = SKAction.run {
                self.view?.presentScene(scene)
            }
            
            let presentSequence = SKAction.sequence([SKAction.wait(forDuration: 1), presentScene])
            
            run(presentSequence)
        }
    }
    
    func tryAgain() {
        if let scene = SKScene (fileNamed: "StageOne") {
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
            if node == button01 {
                presentHomeScene()
                winAudio.stop()
                loseAudio.stop()
            } else if node == button02 && titleLabel.text == "MISI GAGAL" {
                tryAgain()
                winAudio.stop()
                loseAudio.stop()
            }
        }
    }
}
    


