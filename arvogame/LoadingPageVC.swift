//
//  LoadingPageVC.swift
//  arvogame
//
//  Created by I Dewa Agung Ary Aditya Wibawa on 24/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class LoadingPage: UIViewController {

    
    @IBOutlet weak var ProgressView: UIProgressView!
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var descriptionLoading: UILabel!
    
    
    let progress = Progress(totalUnitCount: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customProgressView()
        startprogressing()
        randomContent()
    }
    
    func randomContent(){
        let imageName = [#imageLiteral(resourceName: "snake"), #imageLiteral(resourceName: "snake"), #imageLiteral(resourceName: "snake")]
        let randomName = imageName.randomElement()
        loadingImage.image = randomName
        
        if loadingImage.image == #imageLiteral(resourceName: "snake") {
            descriptionLoading.text = "test test test"
        }
        
//        else if loadingImage.image == #imageLiteral(resourceName: <#T##String#>) {
//            descriptionLoading.text = "test test test"
//        }
//
//        else if loadingImage.image == #imageLiteral(resourceName: <#T##String#>) {
//            descriptionLoading.text = "test test test"
//        }
    }
    
    
    
    func startprogressing() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ (timer) in
        
        guard self.progress.isFinished == false else {
            timer.invalidate()
            /*let storyBoard : UIStoryboard = UIStoryboard(name: "CuciTangan", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CuciTangan")
            nextViewController.modalPresentationStyle = .overCurrentContext
            self.present(nextViewController, animated:true, completion:nil)*/
            return
        }
            
        self.progress.completedUnitCount += 1
        
            let progressFloat = Float(self.progress.fractionCompleted)
            self.ProgressView.setProgress(progressFloat, animated: true)
        }
        
    }
    
    func customProgressView(){
        ProgressView.progress = 0.0
        ProgressView.progressTintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        ProgressView.transform = ProgressView.transform.scaledBy(x: 1, y: 10)
        ProgressView.layer.cornerRadius = 10
        ProgressView.clipsToBounds = true
        
    }
    
    
    }
