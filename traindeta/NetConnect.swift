//
//  NetConnect.swift
//  traindeta
//
//  Created by 熊谷里哉 on 2019/10/11.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NetConnect{
    
    var article: [String: String?] = [:]
    var jrarticles: [[String: String?]] = []
    var odaarticles: [[String: String?]] = []
    var metororaticles: [[String: String?]] = []
    let trainname = TrainName()
    public var favinfo:[String] = []
    public var favsta:[String] = []
    public var favname:[String] = []
    var info : [String] = []
    var status : [String] = []
    let userDefaults = UserDefaults.standard

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
                                self.metororaticles.append(self.article)
                                   
                               }
                self.metoroorganize()
                           
           case .failure(let error):
               print(error)
           }
       }
   }
    func jrorganize(){
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
                favname.append(trainname.jr[i])
            }
        }
        userDefaults.set(favinfo, forKey: "in")
        userDefaults.synchronize()
    }
   func odaorganize(){
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
               favname.append(trainname.oda[i])
           }
       }
    userDefaults.set(favinfo, forKey: "in")
    userDefaults.synchronize()

   }
    func metoroorganize(){
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
                favname.append(trainname.metoro[i])
            }
        }
    userDefaults.set(favinfo, forKey: "in")
    userDefaults.synchronize()

    }
    func connect(){
        favsta = []
        favname = []
        favinfo = []
        jrnet(url:"https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:JR-East&acl:consumerKey=")
       odanet(url: "https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:Odakyu&acl:consumerKey=")
       metoronet(url: "https://api-tokyochallenge.odpt.org/api/v4/odpt:TrainInformation?odpt:operator=odpt.Operator:TokyoMetro&acl:consumerKey=")
       
   }

}
