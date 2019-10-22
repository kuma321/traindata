/// Copyright (c) 2018 Kenty
//
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import AVFoundation
import UIKit

class Alarm{
    
    var selectedWakeUpTime:Date?
    var audioPlayer: AVAudioPlayer!
    var sleepTimer: Timer?
    var seconds = 0
    
    func runTimer(){
        seconds = calculateInterval(userAwakeTime: selectedWakeUpTime!)
        guard sleepTimer == nil else { return }
        if sleepTimer == nil{
            sleepTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    
    @objc private func updateTime(){
        if seconds != 0{
            seconds -= 1
            print(seconds)
        }else{
            sleepTimer?.invalidate()
            sleepTimer = nil
            let soundFilePath = Bundle.main.path(forResource:"alerm1", ofType:"mp3")!
            let sound:URL = URL(fileURLWithPath: soundFilePath)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [])
                    try AVAudioSession.sharedInstance().setActive(true)
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
            } catch {
                print("Cannot load file")
            }
            audioPlayer.play()
            print(audioPlayer.isPlaying)
            
        }
    }
    
    func stopTimer(){
        if sleepTimer != nil {
            sleepTimer!.invalidate()
            sleepTimer = nil
            print("stop")
        }else{
            //タイマーを止める
            audioPlayer.stop()
        }
        
    }
    
    private func calculateInterval(userAwakeTime:Date)-> Int{
        var interval = Int(userAwakeTime.timeIntervalSinceNow)
        if interval < 0{
            interval = 86400 - (0 - interval)
        }
        let calendar =  Calendar.current
        let seconds = calendar.component(.second, from: userAwakeTime)
        return interval - seconds
    }
}
