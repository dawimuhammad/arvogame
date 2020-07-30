//
//  Loading.swift
//  arvogame
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 29/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import UIKit
import SpriteKit

class Loading: SKScene {
    
    var progressLoading : UIProgressView!
    var informationPicture : SKSpriteNode!
    var informationText : SKLabelNode!
    var informationTitle: SKLabelNode!
    var backgroundLoading : SKSpriteNode!
    let progress = Progress(totalUnitCount: 5)
    let arrayImage = ["ular", "kosmetik", "sawit"]
    var showImage : String?
    
    override func didMove(to view: SKView) {
        
        buildProgressLoading()
        setProgressLoading()
        //buildInformationText()
        //buildInformationImage()
        buildBackground()
    }
    
    func buildInformationImage(){
        
        showImage = arrayImage.randomElement()
        informationPicture = (childNode(withName: "informationPicture") as! SKSpriteNode)
        informationPicture.texture = SKTexture(imageNamed: showImage!)
        informationPicture.zPosition = 1
        
        self.addChild(informationPicture)
        
    }
    
    func buildBackground(){
        
        backgroundLoading = SKSpriteNode(imageNamed: "loading-bg")
        backgroundLoading.size = CGSize(width: 1792, height: 875)
        backgroundLoading.zPosition = 0
        backgroundLoading.position = CGPoint(x: 0, y: 0)
        
        self.addChild(backgroundLoading)
    }
    
    func buildInformationText(){
        
        informationTitle = SKLabelNode(fontNamed: "PressStart2P")
        informationTitle.text = "TAHUKAH KAMU"
        informationTitle.fontSize = 18
        informationTitle.fontColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        informationTitle.zPosition = 2
        informationTitle.position = CGPoint(x: informationText.position.x, y: informationText.position.y-20)
        informationTitle.horizontalAlignmentMode = .left
        
        self.addChild(informationTitle)
        
        switch showImage {
        case "Ular":
            informationText = SKLabelNode(text: "...")
            informationText.fontName = "PressStart2P"
            informationText.fontSize = 12
            informationText.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            informationText.zPosition = 3
            informationText.position = CGPoint(x: 0, y: 0)
            informationText.horizontalAlignmentMode = .left
           
            
            self.addChild(informationText)

            
        case "Kosmetik":
            informationText = SKLabelNode(text: "...")
            informationText.fontName = "PressStart2P"
            informationText.fontSize = 12
            informationText.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            informationText.zPosition = 3
            informationText.position = CGPoint(x: 0, y: 0)
            informationText.horizontalAlignmentMode = .left
            
            self.addChild(informationText)
        
        case "Sawit":
            informationText = SKLabelNode(text: "...")
            informationText.fontName = "PressStart2P"
            informationText.fontSize = 12
            informationText.fontColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            informationText.zPosition = 3
            informationText.position = CGPoint(x: 0, y: 0)
            informationText.horizontalAlignmentMode = .left
            
            self.addChild(informationText)
            
        default:
            break
        }
    }
    
    func buildProgressLoading(){
        
        progressLoading = UIProgressView(frame: CGRect(x: 130, y: 300, width: 600, height: 100))
        progressLoading.progress = 0.0
        progressLoading.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        progressLoading.progressTintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        progressLoading.transform = progressLoading.transform.scaledBy(x: 1, y: 13)
        progressLoading.layer.cornerRadius = 30
        progressLoading.clipsToBounds = true
        
        
        self.view?.addSubview(progressLoading)
    }
    
    func setProgressLoading(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (timer) in
        
        guard self.progress.isFinished == false else {
            timer.invalidate()
            self.presentNextScene()
            self.progressLoading.removeFromSuperview()
            return
        }
            
        self.progress.completedUnitCount += 1
        
            let progressFloat = Float(self.progress.fractionCompleted)
            self.progressLoading.setProgress(progressFloat, animated: true)
        }
        
    }
    
    func presentNextScene(){
        
        if let scene = SKScene(fileNamed: "HomeScene"){
            scene.scaleMode = .aspectFill
            view?.presentScene(scene)
        }
    }
    
}
