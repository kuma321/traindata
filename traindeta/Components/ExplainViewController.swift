//
//  ExplainViewController.swift
//  TrainOpendata
//
//  Created by 熊谷里哉 on 2019/09/29.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit

class ExplainViewController: UIViewController {

    @IBAction func jump(_ sender: Any) {
        let url = URL(string: "https://docs.google.com/forms/d/1siyQdc8azc774DsUy65Kh1uY2hrFZ6C72gK4yJJx74c/edit")
        if UIApplication.shared.canOpenURL(url!) {
            UIApplication.shared.open(url!)
        }
        
    }
    
    @IBAction func page(_ sender: Any) {
        let url = URL(string:"https://sites.google.com/s/1HpYsiy8BrdlB8js0DrfATTMmVy_TQNIX/p/1cp70IzHX1g8KtCBCTd8E6W-KqPKUxhP0/edit")
               if UIApplication.shared.canOpenURL(url!) {
                   UIApplication.shared.open(url!)
               }
        
    }
    @IBAction func goquick(_ sender: Any) {
    }
    override func viewDidLoad() {
           super.viewDidLoad()
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "iPhone XR-XS Max –　統一.png")!)
    }
    

   

}
