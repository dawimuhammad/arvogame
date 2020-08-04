//
//  GameOverStageOne.swift
//  arvogame
//
//  Created by Dorojatun Kuncoro Yekti Raharjo on 04/08/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverStageOne: SKScene {

    override func didMove(to view: SKView) {
           size.width = 1792
           size.height = 828
           
           let midX = size.width/2
           let midY = size.height/2
           
           let gameOverLabel = SKLabelNode(fontNamed: "Avenir-Black")
           gameOverLabel.text = "Game Over"
           gameOverLabel.fontSize = 100
           gameOverLabel.position = CGPoint(x: midX, y: midY)
           gameOverLabel.color = .red
           
           let restartLabel = SKLabelNode(text: "Tap anywhere to restart")
           restartLabel.fontSize = 60
           restartLabel.position = CGPoint(x: midX, y: midY - 150)
           
           addChild(gameOverLabel)
           addChild(restartLabel)
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let scene = SKScene(fileNamed: "StageOne") {
               scene.scaleMode = scaleMode
               view?.presentScene(scene)
           }
       }
}
