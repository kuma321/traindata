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

import UIKit
import AVFoundation

class SetViewController: UIViewController {
    
    let alarm = Alarm()
    
    @IBOutlet var sleepTimePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        sleepTimePicker.datePickerMode = UIDatePicker.Mode.time
        sleepTimePicker.setDate(Date(), animated: false)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone XR-XS Max –　統一.png")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if alarm.sleepTimer != nil{
            alarm.stopTimer()
        }
    }
    
    @IBAction func alarmBtnWasPressed(_ sender: UIButton) {
        let Alert: UIAlertController = UIAlertController(title:"アラーム開始",message:"アラームを開始します。アプリを終了せず、iPhoneの画面を下にしておいてください。",preferredStyle: .alert)
        let CloseAction = UIAlertAction(title: "閉じる", style: .default) {
            action in
            self.n()
        }
        Alert.addAction(CloseAction)
        present(Alert, animated: true, completion: nil)
    }
    func n(){
        alarm.selectedWakeUpTime = sleepTimePicker.date
        alarm.runTimer()
        performSegue(withIdentifier: "Sleep", sender: nil)
    }
}
