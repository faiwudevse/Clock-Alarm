//
//  AudioPlayer.swift
//  AlarmClock
//
//  Created by Fai Wu on 12/11/19.
//  Copyright © 2019 Fai Wu. All rights reserved.
//

import AVFoundation

class AudioPlayer {
    static let shared = AudioPlayer()
    var audioPlayer: AVAudioPlayer?
    var audioFileUrl: URL?
    
    func setupAudioPlayer(audioFileName: String) {
        let path = Bundle.main.path(forResource: audioFileName, ofType: "mp3")!
        audioFileUrl = URL(fileURLWithPath: path)
    }
    
    func playMusic(volume: Float) {
        stopMusic()
        if let url = audioFileUrl {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                guard let audioPlayer = audioPlayer else {return}
                audioPlayer.volume = volume
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    
    func playSmapleMusic() {
        stopMusic()
        if let url = audioFileUrl {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                guard let audioPlayer = audioPlayer else {return}
                audioPlayer.numberOfLoops = 1
                
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(stopMusic), userInfo: nil, repeats: false)
            } catch {
                print(error)
            }
        }
    }

    @objc func stopMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
    
}
