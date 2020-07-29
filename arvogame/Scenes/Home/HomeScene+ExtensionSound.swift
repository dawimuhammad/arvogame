//
//  HomeScene+ExtensionSound.swift
//  arvogame
//
//  Created by Haddawi on 28/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import AVFoundation

extension HomeScene {
    func setupHomesceneBacksongAudio() {
        let sound = Bundle.main.path(forResource: "//BGM-Home", ofType: "wav")
        
        do {
            homeBacksongAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        homeBacksongAudio.play()
    }
    
    func setupButtonStartAudio() {
        let sound = Bundle.main.path(forResource: "//button_click", ofType: "wav")
        
        do {
            buttonStartAudio = try AVAudioPlayer(contentsOf: (URL(fileURLWithPath: sound!)))
        } catch {
            print(error)
        }
    }
    
    func removeHomesceneBacksongAudio() {
        homeBacksongAudio.stop()
    }
}
