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

struct PhysicCategory {
    static let player: UInt32 = 0b1  //1
    static let tuas: UInt32 = 0b10 //2
    static let fire: UInt32 = 0b100 //4
    static let push: UInt32 = 0b1000 //8
    static let finish: UInt32 = 0b10000 //16
}

class StageOne: SKScene {
    
    var player: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var jumpButton: SKSpriteNode!
    
    var pintu: SKSpriteNode!
    
    var cameraNode: SKCameraNode?
    
    var playerDirection: CGFloat = 0.0
    
    var runningAction: SKAction!
    var jumpingAction: SKAction!
    var tuasAction: SKAction!
    
    var lives = 1
       var isAlive: Bool {
           return lives > 0
       }
    
    override func didMove(to view: SKView) {
        
        setupRunningAction()
        setupJumpingAction()
        //givePhysicMap()
        
        player = (childNode(withName: "player") as! SKSpriteNode)
        leftButton = (childNode(withName: "//leftButton") as! SKSpriteNode)
        rightButton = (childNode(withName: "//rightButton") as! SKSpriteNode)
        jumpButton = (childNode(withName: "//jumpButton") as! SKSpriteNode)
        cameraNode = (childNode(withName: "camera") as! SKCameraNode)
        pintu = (childNode(withName: "pintu") as! SKSpriteNode)
        
        
       
        physicsWorld.contactDelegate = self
        
//        for node in self.children{
//            if (node.name == "mapStageOne"){
//                if let someTilemap: SKTileMapNode = node as? SKTileMapNode{
//                    giveTileMapNodePhysic(map: someTilemap)
//                    someTilemap.removeFromParent()
//                }
//                break
//            }
//        }
        
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode {
            
            if node == leftButton {
                player.xScale = -1
                player.yScale = 1
                //                      dino.removeAction(forKey: "idleAnimation")
                player.run(runningAction, withKey: "runningAnimation")
                playerDirection = -1
                
            } else if node == rightButton {
                player.xScale = 1
                player.yScale = 1

                //                      dino.removeAction(forKey: "idleAnimation")
                player.run(runningAction, withKey: "runningAnimation")
                playerDirection = 1
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
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        playerDirection = 0
        
        player.removeAction(forKey: "runningAnimation")
        
        //player.removeAction(forKey: "jumping")
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let newPositionX = player.position.x + (playerDirection * 10)
        
        player.position.x = newPositionX
        self.camera?.position.x = newPositionX
        self.camera?.position.y = player.position.y + 200
//        cameraNode!.position.x = player.position.x/2
//        cameraNode!.position.y = player.position.y/2

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
      //  jumpingAction = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.1))
        
        jumpingAction = SKAction.repeat(SKAction.animate(with: textures, timePerFrame: 0.1), count: 1)
           
          }
    
    func setupDyingPLayer(){
        player.removeAllActions()
        
        let gameOver = GameOverStageOne(size: view!.frame.size)
        
        gameOver.scaleMode = scaleMode
        
        let transition = SKTransition.fade(with: .red, duration: 1)
        let presentAction = SKAction.run {
            self.view?.presentScene(gameOver, transition: transition)
        }
        
        let gameOverSequence = SKAction.sequence([SKAction.wait(forDuration: 1), presentAction])
        
        run(gameOverSequence)
        
    }
    
    func setupFinishPLayer(){
         player.removeAllActions()
         
         let finishStage = FinishStageOne(size: view!.frame.size)
         
         finishStage.scaleMode = scaleMode
         
         let transition = SKTransition.fade(with: .green, duration: 0.5)
         let presentAction = SKAction.run {
             self.view?.presentScene(finishStage, transition: transition)
         }
         
         let finishStageSequence = SKAction.sequence([SKAction.wait(forDuration: 1), presentAction])
         
         run(finishStageSequence)
         
     }
    
    func setupTuas(asset: SKSpriteNode){
        var textures = [SKTexture]()
              for i in 1...2 {
                  textures.append(SKTexture(imageNamed: "Tuas(\(i))"))
              }
        tuasAction = SKAction.repeat(SKAction.animate(with: textures, timePerFrame: 0.2), count: 1)
        
        asset.run(tuasAction,withKey: "changeTuas")
    }
    
    
    //Rectangle
//    func givePhysicMap(){
//
//        guard let tilemap = childNode(withName: "mapStageOne") as? SKTileMapNode else { return }
//        let tileSize = tilemap.tileSize
//                let halfWidth = CGFloat(tilemap.numberOfColumns) / 2.0 * tileSize.width
//                let halfHeight = CGFloat(tilemap.numberOfRows) / 2.0 * tileSize.height
//                for row in 0..<tilemap.numberOfRows {
//                    for col in 0..<tilemap.numberOfColumns {
//
//                        if let tileDefinition = tilemap.tileDefinition(atColumn: col, row: row) {
//
//                            let tileArray = tileDefinition.textures
//                            let tileTexture = tileArray[0]
//                            let x = CGFloat(col) * tileSize.width - halfWidth
//                            let y = CGFloat(row) * tileSize.height - halfHeight
//                            let rect = CGRect(x: 0, y: 0, width: tileSize.width, height: tileSize.height)
//                            let tileNode = SKShapeNode(rect: rect)
//                            tileNode.position = CGPoint(x: x, y: y)
//                            tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 40, height: 5), center: CGPoint(x: tileSize.width / 2.0, y: 0))
//                            tileNode.physicsBody?.linearDamping = 60.0
//                            tileNode.physicsBody?.affectedByGravity = false
//                            tileNode.physicsBody?.allowsRotation = false
//                            tileNode.physicsBody?.restitution = 0.0
//                            tileNode.physicsBody?.isDynamic = false
//                            tileNode.physicsBody?.collisionBitMask = 2
//                            tileNode.physicsBody?.categoryBitMask = 1
//                            tileNode.physicsBody?.contactTestBitMask = 2 | 1
//                            tileNode.name = "Ground"
//                            tilemap.addChild(tileNode)
//                        }
//                    }
//                }
//
//        }
    
    //TEXTURE
//    func giveTileMapNodePhysic(map: SKTileMapNode){
//        let tileMap = map
//
//        let startingLocation: CGPoint = tileMap.position
//
//        let tileSize = tileMap.tileSize
//
//        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
//        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height
//
//        for col in 0..<tileMap.numberOfColumns{
//            for row in 0..<tileMap.numberOfRows{
//
//                if let tileDefiniton = tileMap.tileDefinition(atColumn: col, row: row){
//
//                    let tileArray = tileDefiniton.textures
//                    let tileTexture = tileArray.count
//
//                    let x = CGFloat(col) * tileSize.width - halfWidth + (tileSize.width / 2)
//                    let y = CGFloat(row) * tileSize.height - halfHeight + (tileSize.height / 2)
//
//                    let tileNode = SKNode()
//                    tileNode.position = CGPoint(x: x, y: y)
//                    tileNode.physicsBody = SKPhysicsBody(texture: tileTexture, size: CGSize(width: (tileTexture.size().width), height: (tileTexture.size().height)))
//                    tileNode.physicsBody?.linearDamping = 60
//                    tileNode.physicsBody?.affectedByGravity = false
//                    tileNode.physicsBody?.allowsRotation = false
//                    tileNode.physicsBody?.isDynamic = false
//                    tileNode.physicsBody?.friction = 1
//
//                    self.addChild(tileNode)
//
//                    tileNode.position = CGPoint(x: tileNode.position.x + startingLocation.x, y: tileNode.position.y + startingLocation.y)
//                }
//            }
//        }
//    }
    
    

    }
    

extension StageOne: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        //contact 1 buat jump
        if contactMask == PhysicCategory.player | PhysicCategory.push{
           let jumpUpAction = SKAction.moveBy(x: 0, y: 350, duration: 0.5)
           // move down 20
           //let jumpDownAction = SKAction.moveBy(x: 0, y: -200, duration: 0.2)
           // sequence of move yup then down
           let jumpSequence = SKAction.sequence([jumpUpAction])

           // make player run sequence
           player.run(jumpSequence)
           player.run(jumpingAction, withKey: "jumpingAnimation")
        }else if contactMask == PhysicCategory.player | PhysicCategory.tuas{
            let tuas = (contact.bodyB.node?.name == "tuas" ? contact.bodyB.node : contact.bodyA.node) as! SKSpriteNode
            setupTuas(asset: tuas)
            self.removeChildren(in: [pintu])
            
//             var node: SKNode? = nil
//            if contact.bodyA.node?.name == "player" {
//                node?.name = "pintu"
//                    }
//            else {
//                node?.name = "pintu"
//                    }
//            node?.run(SKAction.removeFromParent())
            
        } else if contactMask == PhysicCategory.player | PhysicCategory.fire{
            if !isAlive {
                    return
                }
                
                lives += -1
                
                if !isAlive {
                    setupDyingPLayer()
                }
                
//                var node: SKNode? = nil
//                if contact.bodyA.node?.name == "player" {
//                    node = contact.bodyA.node
//                } else {
//                    node = contact.bodyB.node
//                }
//                node?.run(SKAction.removeFromParent())
            }else if contactMask == PhysicCategory.player | PhysicCategory.finish{
            
           setupFinishPLayer()
        }
          
            
        }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
}


