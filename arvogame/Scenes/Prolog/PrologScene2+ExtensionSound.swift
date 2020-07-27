//
//  PrologScene2+ExtensionSound.swift
//  arvogame
//
//  Created by Haddawi on 27/07/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import AVFoundation

extension PrologScene2 {
    func setupProlog2BacksongAudio() {
        let sound = Bundle.main.path(forResource: "//BGM-Intro", ofType: "mp3")
        
        do {
            prolog2BacksongAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
        
        prolog2BacksongAudio.play()
    }
    
    func removeProlog2BacksongAudio() {
        prolog2BacksongAudio.stop()
    }
}
