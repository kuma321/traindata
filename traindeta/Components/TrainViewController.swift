//
//  TrainViewController.swift
//  TrainOpendata
//
//  Created by 熊谷里哉 on 2019/09/29.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TrainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
   
    let netconnect = NetConnect()
    let table = UITableView()
    var articles: [[String: String?]] = []
    var favour : [String] = []
    var addBtn: UIBarButtonItem!
    var info : [String] = []
    var status : [String] = []
    var x = 0
    let train = ["中央線快速","中央・総武線各駅停車","八高線","伊東線","五日市線","常磐線","常磐線各駅停車","常磐線快速","鹿島線","川越線","京浜東北線・根岸線","京葉線","久留里線","武蔵野線","南武線","南武線浜川崎支線","成田線","成田線我孫子支線","成田線空港支線","青梅線","相模線","埼京線・川越線","湘南新宿ライン","総武線","総武線快速","外房線","高崎線","東金線","東海道線","鶴見線","鶴見線大川支線","鶴見線海芝浦支線","内房線","宇都宮線","山手線","横浜線","横須賀線"]
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
                self.navigationController?.popViewController(animated: true)
               title = "遅延情報"
        addBtn = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(self.onClick))
                self.navigationItem.leftBarButtonItem = addBtn
               table.frame = view.frame
                table.dataSource = self
                table.delegate = self
               view.addSubview(table)
               table.dataSource = self
            net(url:"https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:JR-East&acl:consumerKey=dec8c179df3f39d48cfb49b072b0a63e08603e983acc06ae177f26307a8020ac")
              
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func net(url:String) {
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
                                        "traininfo":json["odpt:trainInformationText"]["ja"].stringValue
                                    
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
           info.append(article["traininfo"]!!)
           status.append(article["train"]!!)
            cell.textLabel?.text = train0
            cell.accessoryType = .detailButton
           return cell
       }
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
            //ボタンの処理
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        x = indexPath.row
        print("\(x)番セルが押されたよ！")
        print(train[x])
        print(info[x])
        performSegue(withIdentifier:"model", sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
           if segue.identifier == "model" {
            
               let nextView = segue.destination as! PopupViewController
    
               nextView.train = train[x]
               nextView.result = info[x]
               nextView.sta = status[x]
           }
       }
    
    @objc func onClick() {
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Select") as! SelectViewController
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
}
