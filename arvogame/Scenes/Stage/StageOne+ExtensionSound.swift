//
//  StageOne+ExtensionSound.swift
//  arvogame
//
//  Created by Haddawi on 05/08/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import AVFoundation

extension StageOne {
    func setupStageOneBacksongAudio() {
        let sound = Bundle.main.path(forResource: "BGM-Stage-1", ofType: "wav")
        
        do {
            stageOneBacksongAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        stageOneBacksongAudio.numberOfLoops = 10
        stageOneBacksongAudio.play()
    }
    
    func setupRunningAudio() {
        let sound = Bundle.main.path(forResource: "SFX-footstep", ofType: "wav")
        
        do {
            runAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
    }
    
    func setupJumpAudio() {
        let sound = Bundle.main.path(forResource: "SFX-char-jump", ofType: "wav")
        
        do {
            jumpAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
    }
    
    func setupCharDamageAudio() {
        let sound = Bundle.main.path(forResource: "SFX-char-damage", ofType: "mp3")
        
        do {
            charDamageAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
    }
    
}
