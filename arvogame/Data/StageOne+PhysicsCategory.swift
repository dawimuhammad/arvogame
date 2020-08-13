//
//  StageOne+PhysicsCategory.swift
//  arvogame
//
//  Created by Haddawi on 06/08/20.
//  Copyright © 2020 Arvo Team. All rights reserved.
//

import Foundation

struct PhysicCategory {
    static let player: UInt32 = 0b1  //1
    static let tuas: UInt32 = 0b10 //2
    static let fire: UInt32 = 0b100 //4
    static let push: UInt32 = 0b1000 //8
    static let finish: UInt32 = 0b10000 //16
    static let photo1: UInt32 = 0b100000 // 32
    static let photo2: UInt32 = 0b1000000 // 64
    static let photo3: UInt32 = 0b10000000 // 128
    static let photo4: UInt32 = 0b100000000 // 256
    static let ground: UInt32 = 0b1000000000 // 512
    static let ular: UInt32 = 0b10000000000 // 1024
}
