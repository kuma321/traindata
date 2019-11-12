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
    var getjr :[Int] = []
    var getoda :[Int] = []
    var getmetoro : [Int] = []
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var fav: UILabel!
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
     }
    override func viewDidLoad() {
          super.viewDidLoad()
          userDefaults.synchronize()
          self.line.text = train
          self.info.text = result
          self.status.text = sta
          change(s:sw,ii:i)
      }
      
      override func didReceiveMemoryWarning() {
             super.didReceiveMemoryWarning()
         }
    @IBOutlet weak var uifavswitch: UISwitch!
    @IBAction func favswitch(_ sender: UISwitch) {
        if sender.isOn == true {
           fav.text = "設定中"
            if sw == 0{
                if t(key: "setjr"){
                    getjr = userDefaults.array(forKey: "setjr") as! [Int]}
                getjr.append(i)
                userDefaults.set(getjr, forKey: "setjr")
            }
            else if sw == 1{
                if t(key: "setoda"){
                    getoda = userDefaults.array(forKey: "setoda") as! [Int]}
                getoda.append(i)
                userDefaults.set(getoda, forKey: "setoda")
                print(getoda)
            }
            else if sw == 2{
                if t(key: "setmero"){
                    getmetoro = userDefaults.array(forKey: "setmetoro") as! [Int]}
                getmetoro.append(i)
                userDefaults.set(getmetoro, forKey: "setmetoro")
                print(getmetoro)
            }
        } else {
            fav.text = ""
            if sw == 0{
                if let x = jr.firstIndex(of: i){
                let getjr:[Int] = userDefaults.array(forKey: "setjr") as! [Int]
                jr = getjr
                jr.remove(at: x)
                userDefaults.set(getjr, forKey: "setjr")
                }
            }
            else if sw == 1{
                if let x = oda.firstIndex(of: i){
                let getoda:[Int] = userDefaults.array(forKey: "setoda") as! [Int]
                oda = getoda
                oda.remove(at: x)
                userDefaults.set(getoda,forKey: "setoda")
                }
            }
            else if sw == 2{
                if let x = metoro.firstIndex(of: i){
                let getmetoro:[Int] = userDefaults.array(forKey: "setmetoro") as! [Int]
                metoro = getmetoro
                metoro.remove(at: x)
                userDefaults.set(getmetoro,forKey: "setmetoro")
            }
        }
      }
    }
    func change(s:Int,ii:Int){
        if sw == 0{
            if t(key: "setjr"){
            getjr = userDefaults.array(forKey: "setjr") as! [Int]}
            if getjr.firstIndex(of:ii) != nil {
                uifavswitch.isOn = true
                fav.text = "設定中"
            }
        }
        if sw == 1{
            if t(key: "setoda"){
            getoda = userDefaults.array(forKey: "setoda") as! [Int]}
            if getoda.firstIndex(of: ii) != nil{
                uifavswitch.isOn = true
                fav.text = "設定中"
            }
        }
        if sw == 2 {
             if t(key: "setmetoro"){
             getmetoro = userDefaults.array(forKey: "setmetoro") as! [Int]}
            if getmetoro.firstIndex(of: ii) != nil{
                uifavswitch.isOn = true
                fav.text = "設定中"
            }
        }
        
    }
    func t(key: String) -> Bool{
        return UserDefaults.standard.object(forKey:key) != nil
    }
}
