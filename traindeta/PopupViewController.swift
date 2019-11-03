//
//  PopupViewController.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/11/02.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func didReceiveMemoryWarning() {
           super.didReceiveMemoryWarning()
       }
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var info: UILabel!
    @IBAction func didTapClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
     }
     // MARK: - Navigation

}
