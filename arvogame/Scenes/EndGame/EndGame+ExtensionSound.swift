//
//  EndGame+ExtensionSound.swift
//  arvogame
//
//  Created by Haddawi on 06/08/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import AVFoundation

extension EndGame {
    func setupWinAudio() {
        let sound = Bundle.main.path(forResource: "BGM-Win-Stage", ofType: "wav")
        
        do {
            winAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        winAudio.numberOfLoops = 10
    }
    
    func setupLoseAudio() {
        let sound = Bundle.main.path(forResource: "BGM-Lose-Game", ofType: "mp3")
        
        do {
            loseAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        loseAudio.numberOfLoops = 10
    }
}
