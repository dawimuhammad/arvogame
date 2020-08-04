//
//  FinishStageOne.swift
//  arvogame
//
//  Created by Dorojatun Kuncoro Yekti Raharjo on 04/08/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import SpriteKit

class FinishStageOne: SKScene {

    override func didMove(to view: SKView) {
           size.width = 1792
           size.height = 828
           
           let midX = size.width/2
           let midY = size.height/2
           
           let finishLabel = SKLabelNode(fontNamed: "Avenir-Black")
          finishLabel.text = "Stage Complete"
           finishLabel.fontSize = 100
           finishLabel.position = CGPoint(x: midX, y: midY)
           finishLabel.color = .red
           
           let restartLabel = SKLabelNode(text: "Tap anywhere to back Menu")
           restartLabel.fontSize = 60
           restartLabel.position = CGPoint(x: midX, y: midY - 150)
           
           addChild(finishLabel)
           addChild(restartLabel)
       }
       
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           if let scene = SKScene(fileNamed: "HomeScene") {
               scene.scaleMode = scaleMode
               view?.presentScene(scene)
           }
       }
}
