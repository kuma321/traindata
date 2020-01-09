//
//  SetViewController.swift
//  TrainOpendata
//
//  Created by 熊谷里哉 on 2019/09/29.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {
    
    let alarm = Alarm()

    @IBOutlet weak var sleepTimePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        sleepTimePicker.datePickerMode = UIDatePicker.Mode.time
               sleepTimePicker.setDate(Date(), animated: false)
           }
           
    override func viewDidAppear(_ animated: Bool) {
            if alarm.sleepTimer != nil{
                   alarm.stopTimer()
               }
    }
    

    
    @IBAction func alarmBtnWasPressed(_ sender: UIButton) {
        alarm.selectedWakeUpTime = sleepTimePicker.date
        alarm.runTimer()
        
    }
}
