//
//  FavoriteViewController.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/10/25.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit
import Alamofire
import Alamofire_Synchronous
import SwiftyJSON

class FavoriteViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    let train = TrainName()
    let table = UITableView()
    var keepAlive = true
    var addBtn: UIBarButtonItem!
     let userDefaults = UserDefaults.standard
    var count = 0
    var x = 0
    var article: [String: String?] = [:]
    var jrarticles: [[String: String?]] = []
    var odaarticles: [[String: String?]] = []
    var metororaticles: [[String: String?]] = []
    public var favinfo:[String] = []
    public var favsta:[String] = []
    public var favname:[String] = []
    var getjr:[Int] = []
    var getoda:[Int] = []
     var getmetoro:[Int] = []
  
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if(t(key: "setjr")){
                getjr = []
            }
            else{
                getjr = userDefaults.array(forKey: "setjr") as! [Int]
            }
            if((t(key: "setoda"))){
                getoda = []
            }
            else{
                getoda = userDefaults.array(forKey: "setoda") as! [Int]
            }
            if((t(key: "setmetoro"))){
                getmetoro = []
            }
            else{
                    getmetoro = userDefaults.array(forKey: "setmetoro") as! [Int]
            }
            let c = getjr.count + getoda.count + getmetoro.count
            return c
            }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
           let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
            cell.detailTextLabel?.text = favinfo[indexPath.row]
            cell.textLabel?.text = favname[indexPath.row]
             cell.accessoryType = .detailButton
            return cell
           
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        x = indexPath.row
        print("\(x)番セルが押されたよ！")
        performSegue(withIdentifier:"favgo", sender: nil)
        
    }
        @objc func onClick() {
              let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "Select") as! SelectViewController
              self.present(secondViewController, animated: true, completion: nil)
            
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
                                           "traininfo":json["odpt:trainInformationText"]["ja"].stringValue
                                       
                                       ]
                                       self.jrarticles.append(article)
                                   }
                               self.jrorganize()
                               
               case .failure(let error):
                   print(error)
               }
               
           }
       }
     func odanet(url:String) {
         Alamofire.request(url, method: .get).responseJSON { response in
              switch response.result {
              case.success:
                  print("成功")
                  guard let object = response.result.value else {
                      return
                  }
                  let json = JSON(object)
                                 json.forEach { (_, json) in
                                  self.article = [
                                         "train":json["odpt:trainInformationStatus"]["ja"].stringValue,
                                         "traininfo":json["odpt:trainInformationText"]["ja"].stringValue
                                     
                                     ]
                                  self.odaarticles.append(self.article)
                                     
                                 }
                  self.odaorganize()
             case .failure(let error):
                 print(error)
             }
         }
     }
     func metoronet(url:String) {

         Alamofire.request(url, method: .get).responseJSON { response in
              switch response.result {
              case.success:
                  print("成功")
                  guard let object = response.result.value else {
                      return
                  }
                  let json = JSON(object)
                                 json.forEach { (_, json) in
                                  self.article = [
                                         "train":json["odpt:trainInformationStatus"]["ja"].stringValue,
                                         "traininfo":json["odpt:trainInformationText"]["ja"].stringValue
                                     
                                     ]
                                    self.keepAlive = false
                                  self.metororaticles.append(self.article)
                                     
                                 }
                  self.metoroorganize()
                             
             case .failure(let error):
                 print(error)
             }
         }
     }
      func jrorganize(){
        var info : [String] = []
           var status : [String] = []
           let getjr:[Int] = userDefaults.array(forKey: "setjr") as! [Int]
          for x in 0..<jrarticles.count{
              article = jrarticles[x]
              info.append(article["train"]!!)
              status.append(article["traininfo"]!!)
          }
          for i in 0..<jrarticles.count{
              if getjr.firstIndex(of:i) != nil{
                  favinfo.append(info[i])
                  favsta.append(status[i])
                  favname.append(train.jr[i])
              }
          }
    
      }
     func odaorganize(){
        var info : [String] = []
           var status : [String] = []
          let getoda:[Int] = userDefaults.array(forKey: "setoda") as! [Int]
         for x in 0..<jrarticles.count{
             article = jrarticles[x]
             info.append(article["train"]!!)
             status.append(article["traininfo"]!!)
         }
         for i in 0..<jrarticles.count{
             if getoda.firstIndex(of:i) != nil{
                 favinfo.append(info[i])
                 favsta.append(status[i])
                 favname.append(train.oda[i])
             }
         }
     }
      func metoroorganize(){
        var info : [String] = []
           var status : [String] = []
           let getmetoro:[Int] = userDefaults.array(forKey: "setmetoro") as! [Int]
          for x in 0..<jrarticles.count{
              article = jrarticles[x]
              info.append(article["train"]!!)
              status.append(article["traininfo"]!!)
          }
          for i in 0..<jrarticles.count{
              if getmetoro.firstIndex(of:i) != nil{
                  favinfo.append(info[i])
                  favsta.append(status[i])
                  favname.append(train.metoro[i])
              }
          }
        
        Swift.print(favname)
        
      }
    override func viewDidLoad() {
           jrnet(url:"https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:JR-East&acl:consumerKey=dec8c179df3f39d48cfb49b072b0a63e08603e983acc06ae177f26307a8020ac")
           odanet(url: "https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:Odakyu&acl:consumerKey=dec8c179df3f39d48cfb49b072b0a63e08603e983acc06ae177f26307a8020ac")
           metoronet(url: "https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:TokyoMetro&acl:consumerKey=dec8c179df3f39d48cfb49b072b0a63e08603e983acc06ae177f26307a8020ac")
        let runLoop = RunLoop.current
       while keepAlive &&
        runLoop.run(mode: RunLoop.Mode.default, before: NSDate(timeIntervalSinceNow: 0.1) as Date) {
       }
        
             super.viewDidLoad()
             userDefaults.synchronize()
             self.navigationController?.popViewController(animated: true)
                          title = "遅延情報"
             self.navigationItem.leftBarButtonItem = UIBarButtonItem(title:"select",style: .plain, target: self, action: #selector(self.onClick))
                          table.frame = view.frame
                         view.addSubview(table)
                         table.dataSource = self
                          table.delegate = self
       
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
           if segue.identifier == "favgo" {
            
               let nextView = segue.destination as! FavPopViewController
    
               nextView.train = favname[x]
               nextView.result = favinfo[x]
               nextView.sta = favsta[x]
           }
       }
    func t(key: String) -> Bool{
        return UserDefaults.standard.object(forKey:key) == nil
    }
         

}

