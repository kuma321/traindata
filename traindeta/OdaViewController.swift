//
//  OdaViewController.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/10/17.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class OdaViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    let table = UITableView()
    var articles: [[String: String?]] = []
    var addBtn: UIBarButtonItem!
    let train=["小田急線"]

    override func viewDidLoad() {
        super.viewDidLoad()
                self.navigationController?.popViewController(animated: true)
               title = "遅延情報"
        addBtn = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(self.onClick))
                self.navigationItem.leftBarButtonItem = addBtn
                table.dataSource = self
                table.delegate = self
               table.frame = view.frame
               view.addSubview(table)
               table.dataSource = self
        jrnet(url: "https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:Odakyu&acl:consumerKey=dec8c179df3f39d48cfb49b072b0a63e08603e983acc06ae177f26307a8020ac")
                
    }
    func jrnet(url:String) {
           Alamofire.request(url, method: .get).responseJSON { response in
                switch response.result {
                case.success:
                    print("成功")
                    guard let object = response.result.value else {
                        return
                    }
                    let json = JSON(object)
                                   json.forEach { (_, json) in
                                       let article: [String: String?] = [

                                        "train":json["odpt:trainInformationStatus"]["ja"].stringValue,
                                                 "traininfo":json["odpt:trainInformationText"].stringValue
                                       ]
                                       self.articles.append(article)
                                   }
                              
                               self.table.reloadData()
                               
                               
               case .failure(let error):
                   print(error)
               }
           }
       }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles.count
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let article = articles[indexPath.row]
        let train0 = train[indexPath.row]
       cell.detailTextLabel?.text = article["train"]!
        cell.textLabel?.text = train0
        cell.accessoryType = UITableViewCell.AccessoryType.detailButton
       return cell
    
    }
    @objc func onClick() {
          let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Select") as! SelectViewController
          self.present(secondViewController, animated: true, completion: nil)}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("\(indexPath.row)番セルが押されたよ！")
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopupViewController") else { return }
        self.present(vc, animated: false, completion: nil)
    }

}
