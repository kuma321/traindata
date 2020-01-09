//
//  SleepViewController.swift
//  TrainOpendata
//
//  Created by 熊谷里哉 on 2019/09/29.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit

class SleepViewController: UIViewController {
    
    var currentTime = CurrentTime()
    let alarm = Alarm()
    let netconnect = NetConnect()
    var normal :CGFloat = 0
    var timer: Timer?
    var i : [String] = []
    var sw = "t"
     let userDefaults = UserDefaults.standard
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone XR-XS Max – 夜.png")!)
        normal = UIScreen.main.brightness
        UIScreen.main.brightness = 0.0
        currentTime.delegate = self
        netconnect.connect()
        Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(self.timechange), userInfo: nil, repeats: true)
    }
    
    @IBAction func timeup(_ sender: UIButton) {
        UIScreen.main.brightness = CGFloat(normal)
           self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
           
        
    
    }
    
    func updateTime(_ time:String) {
             timeLabel.text = time
             
        }
    @objc func timechange(){
         let qtime = userDefaults.integer(forKey: "time") * 60
        netconnect.connect()
        userDefaults.synchronize()
        i =  UserDefaults.standard.object(forKey:"in") as! [String]
        print(i)
        if(i.contains("運転見合わせ")||i.contains("遅延")){
            if(sw == "t"){
                print(alarm.seconds)
                print(qtime)
                    alarm.seconds -= qtime
                    sw = "f"
            }
        }
        if(!(i.contains("運転見合わせ")||i.contains("遅延"))){
            if(sw == "f"){
            alarm.seconds += qtime
            sw = "t"
            }
        }
       
    }

}
