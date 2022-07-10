//
//  Audio.swift
//  PlayerTestTask
//
//  Created by Максим Пасюта on 06.04.2022.
//

import Foundation
import AVFoundation


// Add
class Audio: NSObject, AVAudioPlayerDelegate {
    
    static let shared = Audio()
    
    private override init() {}
    
    private var firstTrackTime = 0.0
    private var secondPTrackTime = 0.0
    
    private var firstPlayer: AVAudioPlayer!
    private var secondPlayer: AVAudioPlayer!
    

    private func infinitySound (firstTrack: URL?, secondTrack: URL?, crossfade: Int){
        
        guard let firstTrack = firstTrack else { return }
        guard let secondTrack = secondTrack else { return }
        
        print(firstTrack)
        
        do {
            firstPlayer = try AVAudioPlayer(contentsOf: firstTrack)
            secondPlayer = try AVAudioPlayer(contentsOf: secondTrack)
        }
        catch(let error) {
            print(error)
        }
        
        let firstEndingTime = firstPlayer.duration - TimeInterval(crossfade)
        let secondEndingTime = secondPlayer.duration - TimeInterval(crossfade)
        
        DispatchQueue.global().async { [weak self] in
            
            guard let self = self else { return }
            
            while true {
                
                if !self.firstPlayer.isPlaying{
                    self.firstPlayer.play()
                }
                
                sleep(UInt32(firstEndingTime))
                self.secondPlayer.play()
                self.firstPlayer.setVolume(0, fadeDuration: TimeInterval(crossfade))
                self.secondPlayer.setVolume(1, fadeDuration: TimeInterval(crossfade))
                sleep(UInt32(crossfade))
                self.firstPlayer = try? AVAudioPlayer(contentsOf: firstTrack)
                
                sleep(UInt32(secondEndingTime))
                self.firstPlayer.play()
                self.secondPlayer.setVolume(0, fadeDuration: TimeInterval(crossfade))
                self.firstPlayer.setVolume(1, fadeDuration: TimeInterval(crossfade))
                sleep(UInt32(crossfade))
                self.secondPlayer = try? AVAudioPlayer(contentsOf: secondTrack)
                
            }
        }
    }
    
    public func playSounds(firstTrack: URL?, secondTrack: URL?, crossfade: Int){
        infinitySound(firstTrack: firstTrack, secondTrack: secondTrack, crossfade: crossfade)
    }
}
