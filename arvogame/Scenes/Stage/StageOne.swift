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
    static let ground: UInt32 = 0b10 //2
    static let fire: UInt32 = 0b100 //4
    static let push: UInt32 = 0b1000 //8
}

class StageOne: SKScene {
    
    var player: SKSpriteNode!
    var leftButton: SKSpriteNode!
    var rightButton: SKSpriteNode!
    var jumpButton: SKSpriteNode!
    
    var playerDirection: CGFloat = 0.0
    
    var runningAction: SKAction!
    var jumpingAction: SKAction!
    
    override func didMove(to view: SKView) {
        
        setupRunningAction()
        setupJumpingAction()
        //givePhysicMap()
        
        player = (childNode(withName: "player") as! SKSpriteNode)
        leftButton = (childNode(withName: "//leftButton") as! SKSpriteNode)
        rightButton = (childNode(withName: "//rightButton") as! SKSpriteNode)
        jumpButton = (childNode(withName: "//jumpButton") as! SKSpriteNode)
        
        physicsWorld.contactDelegate = self
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        
        if let node = self.nodes(at: touch.location(in: self)).first as? SKSpriteNode {
            
            if node == leftButton {
                player.xScale = -3.75
                player.yScale = 3.75
                //                      dino.removeAction(forKey: "idleAnimation")
                player.run(runningAction, withKey: "runningAnimation")
                playerDirection = -1
                
            } else if node == rightButton {
                player.xScale = 3.75
                player.yScale = 3.75
                //                      dino.removeAction(forKey: "idleAnimation")
                player.run(runningAction, withKey: "runningAnimation")
                playerDirection = 1
            } else if node == jumpButton{
                
                player.removeAction(forKey: "runningAnimation")
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
        player.removeAction(forKey: "jumpingAction")
        player.removeAction(forKey: "runningAnimation")
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let newPosition = player.position.x + (playerDirection * 10)
        
        player.position.x = newPosition
        self.camera?.position.x = newPosition

    }
    
    func setupRunningAction() {
           var textures = [SKTexture]()
           for i in 1...5 {
               textures.append(SKTexture(imageNamed: "run-\(i)"))
           }
           runningAction = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.1))
        
        
       }
    
    func setupJumpingAction() {
              var textures = [SKTexture]()
              for i in 1...4 {
                  textures.append(SKTexture(imageNamed: "jump-\(i)"))
              }
        jumpingAction = SKAction.repeatForever(SKAction.animate(with: textures, timePerFrame: 0.2))
           
           
          }
    
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
//                            tileNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 15, height: 15), center: CGPoint(x: tileSize.width / 2.0, y: tileSize.height / 2.0))
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
    
    }

extension StageOne: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == PhysicCategory.player | PhysicCategory.push{
           let jumpUpAction = SKAction.moveBy(x: 0, y: 350, duration: 0.5)
           // move down 20
           //let jumpDownAction = SKAction.moveBy(x: 0, y: -200, duration: 0.2)
           // sequence of move yup then down
           let jumpSequence = SKAction.sequence([jumpUpAction])

           // make player run sequence
           player.run(jumpSequence)
           player.run(jumpingAction, withKey: "jumpingAnimation")
        }else if contactMask == PhysicCategory.player | PhysicCategory.ground{
            print("contact")
            
        } else if contactMask == PhysicCategory.player | PhysicCategory.fire{
            
        }
    }
    
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
}
