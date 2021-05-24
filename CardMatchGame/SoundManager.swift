//
//  SoundManager.swift
//  CardMatchGame
//
//  Created by OSU App Center on 5/23/21.
//

import Foundation
import AVFoundation

class SoundManager{
    
    var audioPlay:AVAudioPlayer?
    var fileName:String?
    
    enum sound {
        case shuffle
        case flip
        case match
        case notMatch
    }
    
    func playSound (effect:sound){
        
        switch effect {
        case .shuffle:
            fileName = "shuffle"
        case .flip:
            fileName = "cardflip"
        case .match:
            fileName = "dingcorrect"
        case .notMatch:
            fileName = "dingwrong"
        }
        
        //get the path to the resource in the bundle
        
        let path = Bundle.main.path(forResource: fileName, ofType: "wav")
        
        guard path != nil else{
            return
        }
        
        let url = URL(fileURLWithPath: path!)
        
        do {
            audioPlay = try AVAudioPlayer(contentsOf: url)
            audioPlay?.play()
        }
        catch{
            print(error)
            return
        }
    }
    
}
