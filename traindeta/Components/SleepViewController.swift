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
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentTime.delegate = self
    }
    
    @IBAction func timeup(_ sender: UIButton) {
           self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    func updateTime(_ time:String) {
             timeLabel.text = time
        }

}
