//
//  StageOne.swift
//  arvogame
//
//  Created by Dorojatun Kuncoro Yekti Raharjo on 27/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit
import AVFoundation

class StageOne: SKScene {
    
    var player: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var jumpButton: SKSpriteNode!
    
    var pintu: SKSpriteNode!
    var photo1: SKSpriteNode!
    var photo2: SKSpriteNode!
    var photo3: SKSpriteNode!
    var photo4: SKSpriteNode!
    
    var lblCountCollectibleItem: SKLabelNode!
    
    var cameraNode: SKCameraNode?
    
    var playerDirection: CGFloat = 0.0
    
    var runningAction: SKAction!
    var jumpingAction: SKAction!
    var tuasAction: SKAction!
    
    var stageOneBacksongAudio = AVAudioPlayer()
    var runAudio = AVAudioPlayer()
    var jumpAudio = AVAudioPlayer()
    var charDamageAudio = AVAudioPlayer()
    
    
    var lives = 1
        var isAlive: Bool {
        return lives > 0
    }
    
    var collectibleItem = 0
    
    override func didMove(to view: SKView) {
        setupRunningAction()
        setupJumpingAction()
        setupStageOneBacksongAudio()
        setupRunningAudio()
        setupJumpAudio()
        setupCharDamageAudio()
        //givePhysicMap()
        
        player = (childNode(withName: "player") as! SKSpriteNode)
        leftButton = (childNode(withName: "//leftButton") as! SKSpriteNode)
        rightButton = (childNode(withName: "//rightButton") as! SKSpriteNode)
        jumpButton = (childNode(withName: "//jumpButton") as! SKSpriteNode)
        cameraNode = (childNode(withName: "camera") as! SKCameraNode)
        pintu = (childNode(withName: "pintu") as! SKSpriteNode)
        lblCountCollectibleItem = (childNode(withName: "//labelPhotoCollectCount") as! SKLabelNode)
        photo1 = (childNode(withName: "photo1") as! SKSpriteNode)
        photo2 = (childNode(withName: "photo2") as! SKSpriteNode)
        photo3 = (childNode(withName: "photo3") as! SKSpriteNode)
        photo4 = (childNode(withName: "photo4") as! SKSpriteNode)
        
        physicsWorld.contactDelegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode {
            
            if node == leftButton {
                player.xScale = -1
                player.yScale = 1
                player.run(runningAction, withKey: "runningAnimation")
                playerDirection = -1
                runAudio.play()
            } else if node == rightButton {
                player.xScale = 1
                player.yScale = 1
                player.run(runningAction, withKey: "runningAnimation")
                playerDirection = 1
                runAudio.play()
            } else if node == jumpButton{
                
                //player.removeAction(forKey: "runningAnimation")
//                player.physicsBody?.restitution = 5.0
                // move up 20
                let jumpUpAction = SKAction.moveBy(x: 0, y: 300, duration: 0.5)
                // move down 20
                //let jumpDownAction = SKAction.moveBy(x: 0, y: -200, duration: 0.2)
                // sequence of move yup then down
                let jumpSequence = SKAction.sequence([jumpUpAction])

                // make player run sequence
                player.run(jumpSequence)
                player.run(jumpingAction, withKey: "jumpingAnimation")
                jumpAudio.play()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerDirection = 0
        player.removeAction(forKey: "runningAnimation")
    }
    
    override func update(_ currentTime: TimeInterval) {
        let newPositionX = player.position.x + (playerDirection * 10)
        
        player.position.x = newPositionX
        self.camera?.position.x = newPositionX
        self.camera?.position.y = player.position.y + 200
    }
    
    func setupRunningAction() {
        var textures = [SKTexture]()
        for i in 1...9 {
           textures.append(SKTexture(imageNamed: "run-\(i)"))
        }

        runningAction = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.1))
   }
    
    func setupJumpingAction() {
        var textures = [SKTexture]()
        for i in 1...5 {
          textures.append(SKTexture(imageNamed: "jump-\(i)"))
        }
        
        jumpingAction = SKAction.repeat(SKAction.animate(with: textures, timePerFrame: 0.1), count: 1)
    }
    
    func presentNextScene() {
        if let scene = SKScene (fileNamed: "EndGame") {
            scene.scaleMode = .aspectFill
            
            let presentScene = SKAction.run {
                self.view?.presentScene(scene)
            }
            
            let presentSequence = SKAction.sequence([SKAction.wait(forDuration: 0.5), presentScene])
            
            run(presentSequence)
        }
    }
    
    func setupDyingPLayer() {
        player.removeAllActions()
        
        UserDefaults.standard.set(false, forKey: "gameIsSuccess")
        presentNextScene()
    }
    
    func setupFinishPLayer() {
        player.removeAllActions()
        UserDefaults.standard.set(true, forKey: "gameIsSuccess" )
        stageOneBacksongAudio.stop()
        presentNextScene()
     }
    
    func setupTuas(asset: SKSpriteNode) {
        var textures = [SKTexture]()
              for i in 1...2 {
                  textures.append(SKTexture(imageNamed: "Tuas(\(i))"))
              }
        tuasAction = SKAction.repeat(SKAction.animate(with: textures, timePerFrame: 0.2), count: 1)
        
        asset.run(tuasAction,withKey: "changeTuas")
    }
    
    func performCollectItemAction() {
        collectibleItem += 1
        lblCountCollectibleItem.text = String(collectibleItem)
        
        run(SKAction.playSoundFileNamed("SFX-collect-item.wav", waitForCompletion: false))
    }
}

extension StageOne: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch contactMask {
        case PhysicCategory.player | PhysicCategory.push:
            // contact character for jumping action
            let jumpUpAction = SKAction.moveBy(x: 0, y: 350, duration: 0.5)
            let jumpSequence = SKAction.sequence([jumpUpAction])

            // run character jump sequence actions
            player.run(jumpSequence)
            player.run(jumpingAction, withKey: "jumpingAnimation")
        case PhysicCategory.player | PhysicCategory.tuas:
            // contact with "tuas"
            let tuas = (contact.bodyB.node?.name == "tuas" ? contact.bodyB.node : contact.bodyA.node) as! SKSpriteNode
            setupTuas(asset: tuas)
            self.removeChildren(in: [pintu])
        case PhysicCategory.player | PhysicCategory.fire:
            // contact with challenge "duri"
            charDamageAudio.setVolume(Float(15), fadeDuration: 1)
            charDamageAudio.play()
            if !isAlive { return }
            lives += -1
            if !isAlive { setupDyingPLayer() }
        case PhysicCategory.player | PhysicCategory.photo1:
            // contact with photo item 1
            photo1.removeFromParent()
            performCollectItemAction()
        case PhysicCategory.player | PhysicCategory.photo2:
            // contact with photo item 2
            photo2.removeFromParent()
            performCollectItemAction()
        case PhysicCategory.player | PhysicCategory.photo3:
            // contact with photo item 3
            photo3.removeFromParent()
            performCollectItemAction()
        case PhysicCategory.player | PhysicCategory.photo4:
            // contact with photo item 4
            photo4.removeFromParent()
            performCollectItemAction()
        default:
            setupFinishPLayer()
        }
    }
}


