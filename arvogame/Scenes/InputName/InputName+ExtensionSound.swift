//
//  InputName+ExtensionSound.swift
//  arvogame
//
//  Created by Haddawi on 04/08/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import AVFoundation

extension InputName {
    func setupButtonStartAudio() {
        let sound = Bundle.main.path(forResource: "//button_click", ofType: "wav")
        
        do {
            buttonStartAudio = try AVAudioPlayer(contentsOf: (URL(fileURLWithPath: sound!)))
        } catch {
            print(error)
        }
    }
}
