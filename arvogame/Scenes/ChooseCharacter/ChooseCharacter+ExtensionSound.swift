//
//  ChooseCharacter+ExtensionSound.swift
//  arvogame
//
//  Created by Haddawi on 05/08/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation
import AVFoundation

extension ChooseCharacter {
    func setupButtonLanjutAudio() {
        let sound = Bundle.main.path(forResource: "//button_click", ofType: "wav")
        
        do {
            buttonLanjutAudio = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        } catch {
            print(error)
        }
    }
}
