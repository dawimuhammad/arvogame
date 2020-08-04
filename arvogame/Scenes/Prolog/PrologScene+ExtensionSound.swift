//
//  PrologScene+ExtensionSound.swift
//  arvogame
//
//  Created by Haddawi on 27/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import AVFoundation

extension PrologScene {
    func setupPrologBacksongAudio() {
        let sound = Bundle.main.path(forResource: "//BGM_Intro", ofType: "mp3")
        
        do {
            prologBacksongAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        prologBacksongAudio.play()
    }
    
    func removePrologBacksongAudio() {
        prologBacksongAudio.stop()
    }
}
