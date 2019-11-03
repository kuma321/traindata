//
//  HomeViewController.swift
//  TrainOpendata
//
//  Created by 熊谷里哉 on 2019/09/29.
//  Copyright © 2019 熊谷里哉. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class HomeViewController: UIViewController,CLLocationManagerDelegate {
    var locationManager: CLLocationManager!
    let alarm = Alarm()
    var currenttime = CurrentTime()
    let weather = WeatherConnect()
    var weatherinfo: [[String: String?]] = []
    var tenkiarray: Array<String> = []
    var weatherarray: Array<String> = []
    var tenki :String = ""
    var Url :String = ""
    var Imagepass  = UIImage(named: "晴れ.png")
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var tenki1: UILabel!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var time3: UILabel!
    @IBOutlet weak var time4: UILabel!
    @IBOutlet weak var time5: UILabel!
    @IBOutlet weak var nowweather: UILabel!
    @IBOutlet weak var weather1: UIImageView!
    @IBOutlet weak var weather2: UIImageView!
    @IBOutlet weak var weather3: UIImageView!
    @IBOutlet weak var weather4: UIImageView!
    @IBOutlet weak var weather5: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.view.backgroundColor = UIColor(patternImage: UIImage(named: "グループ 65-1.png")!)
        currenttime.hoge = self
        setupLocationManager()
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
           if alarm.sleepTimer != nil{
               alarm.stopTimer()
           }
    }
    
    @IBAction func gosleep(_ sender: UIButton) {
        self.performSegue(withIdentifier: "Set", sender: self)
    }
   
    func updateTime(_ time:String) {
        Time.text = time
    }
    func setupLocationManager() {
           locationManager = CLLocationManager()
           guard let locationManager = locationManager else { return }
           locationManager.requestWhenInUseAuthorization()

           let status = CLLocationManager.authorizationStatus()
           if status == .authorizedWhenInUse {
               locationManager.delegate = self
               locationManager.distanceFilter = 100
               locationManager.startUpdatingLocation()
           }
       }

       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           let location = locations.first
           let latitude = location?.coordinate.latitude
           let longitude = location?.coordinate.longitude
           let lat :String = String(latitude!)
           let lon :String = String(longitude!)
           netconnect(lat: lat, lon: lon)
           
       }
    private func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
          NSLog("Error")
      }
    func net(url:String){
           Alamofire.request(url, method: .get).responseJSON { response in
           switch response.result {
            case.success(let value):
                  let json = JSON(value)
                  for i in 0 ..< 8{
                    let dt_txt = json["list"][i]["dt_txt"].stringValue
                    let weatherMain = json["list"][i]["weather"][0]["main"].stringValue
                    self.tenkiarray.append(dt_txt)
                    self.weatherarray.append(weatherMain)
                    /*if i == 2{
                        self.nowweather.text = self.weatherarray[i]
                    }*/
                    if i == 3{
                        let time = self.tenkiarray[i]
                        self.tenki1.text = .init(time[time.index(time.startIndex, offsetBy: 10)..<time.index(time.startIndex, offsetBy: 16)])
                        self.find(t: self.weatherarray[i])
                        self.weather1.image = self.Imagepass
                        
                    }
                    if i == 4{
                        let time = self.tenkiarray[i]
                        self.time2.text = .init(time[time.index(time.startIndex, offsetBy: 10)..<time.index(time.startIndex, offsetBy: 16)])
                        self.find(t: self.weatherarray[i])
                        self.weather2.image = self.Imagepass
                    }
                    if i == 5{
                        let time = self.tenkiarray[i]
                        self.time3.text = .init(time[time.index(time.startIndex, offsetBy: 10)..<time.index(time.startIndex, offsetBy: 16)])
                        self.find(t: self.weatherarray[i])
                        self.weather3.image = self.Imagepass
                    }
                    if i == 6{
                        let time = self.tenkiarray[i]
                        self.time4.text = .init(time[time.index(time.startIndex, offsetBy: 10)..<time.index(time.startIndex, offsetBy: 16)])
                        self.find(t: self.weatherarray[i])
                        self.weather4.image = self.Imagepass
                    }
                    if i == 7 {
                        let time = self.tenkiarray[i]
                        self.time5.text = .init(time[time.index(time.startIndex, offsetBy: 10)..<time.index(time.startIndex, offsetBy: 16)])
                        self.find(t: self.weatherarray[i])
                        self.weather5.image = self.Imagepass
                    }
                  }
            case .failure(let error):
                         print(error)
            }
        }
    }
    func find(t:String){
        if t == "Clear"{
            tenki = "晴れ"
            self.Imagepass = UIImage(named: "晴れ.png")
            
        }
        if t == "Clouds"{
            tenki = "曇り"
            self.Imagepass = UIImage(named: "曇り.png")
        }
        if t == "Rain"{
            tenki = "雨"
            self.Imagepass = UIImage(named: "雨.png")
        }
        if t == "Snow"{
            tenki = "雪"
            self.Imagepass = UIImage(named: "雪.png")
        }
        else{
            
        }
    }
    func netconnect(lat:String,lon:String)  {
        let URL :String =  "https://api.openweathermap.org/data/2.5/forecast?6&lat="+lat+"&lon="+lon+"&cnt=8&APPID=667086c7c86aacbf61429ad78a5023b3"
        net(url: URL)
    }
}
