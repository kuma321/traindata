//
//  quicklyViewController.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/10/23.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit

class quicklyViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource{
    let time : [Int] = [5,10,15,20,25,30,40,50,60,70,80,90,100]

    
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var qtime :Int = 0
    let dataList : [String] = ["5分","10分","15分","20分","25分","30分","40分","50分","60分","70分","80分","90分","100分"]
  
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.frame = CGRect(x: 0, y: 500, width: self.view.frame.width, height: 300)
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone XR-XS Max –　統一.png")!)
      
        
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        return dataList[row]
        
    }
    func pickerView(_ pickerView: UIPickerView,
                       didSelectRow row: Int,
                       inComponent component: Int) {
           
        self.min.text = dataList[row]
        let soeji = pickerView.selectedRow(inComponent: 0)
        qtime = time[soeji]
        print(qtime)
        
       }
    
    @IBAction func back(_ sender: Any) {
    }
    
}
