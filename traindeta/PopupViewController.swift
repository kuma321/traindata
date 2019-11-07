//
//  PopupViewController.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/11/02.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    var train = ""
    var result = ""
    var sta = ""
    var i :Int = 0
    var sw :Int = 0
    var jr :[Int] = []
    var oda :[Int] = []
    var metoro :[Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.line.text = train
        self.info.text = result
        self.status.text = sta
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var fav: UILabel!
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
     }
    @IBAction func favswitch(_ sender: UISwitch) {
        if sender.isOn == true {
           fav.text = "設定中"
            if sw == 0{
                jr.append(i)
            }
            if sw == 1{
                oda.append(i)
            }
            if sw == 2{
                metoro.append(i)
                print(metoro)
            }
        } else {
            fav.text = ""
            if sw == 0{
                jr.remove(at:i)
            }
            if sw == 1{
                oda.remove(at: i)
            }
            if sw == 2{
                metoro.remove(at: i)
            }
         
        }
    }

}
