//
//  SunCalcViewController.swift
//  myPhotoAssistent
//
//  Created by Moritz Rauscher on 15.01.20.
//  Copyright © 2020 Sebastian Gilhofer. All rights reserved.
//

import UIKit
import CoreLocation

class SunCalcViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    private var longitude: Double?
    private var latitude: Double?
    private static var checkAccess: Int = 0
    private var sunDate: Date?
    
    @IBOutlet weak var sunSetLabel: UILabel!
    @IBOutlet weak var sunRiseLabel: UILabel!
    @IBOutlet weak var pickDate: UITextField!
    @IBOutlet weak var latField: UILabel!
    @IBOutlet weak var longField: UILabel!
    
    private var datePicker: UIDatePicker?
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(SunCalcViewController.dateChanged(datePicker:)), for: .valueChanged)
        pickDate.inputView = datePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SunCalcViewController.viewTapped(gestureRecognizer:)))
        
        //set UI textfield
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        pickDate.text=dateFormatter.string(from: Date())
        
        //get Location
        
   //     latField.delegate = self
   //    longField.delegate = self
        if(SunCalcViewController.checkAccess == 0){
        locationManager.requestWhenInUseAuthorization()
            SunCalcViewController.checkAccess = 1
        }
        var currentLoc: CLLocation!
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
           currentLoc = locationManager.location
            latitude = currentLoc.coordinate.latitude
            longitude = currentLoc.coordinate.longitude
            longField.text = String (currentLoc.coordinate.longitude)
            latField.text = String( currentLoc.coordinate.latitude)
        
            var sunCalc = SwiftySuncalc()
            sunDate = dateFormatter.date(from: pickDate.text!)
            if (sunDate != nil){
                sunDate = sunDate! + TimeInterval(TimeZone.current.secondsFromGMT())}
            var sun = sunCalc.getTimes(date: sunDate!, lat: latitude!, lng: longitude!);
            // sun is a Dictionary of type String : Date
            // set Value to sunriseLabel
            print(TimeZone.current.secondsFromGMT())
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            sunRiseLabel.text = dateFormatter.string(from: sun["sunrise"]!)
            sunSetLabel.text = dateFormatter.string(from: sun["sunset"]!)
        }
        
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer ){
        updateLabels()
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker ){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        pickDate.text=dateFormatter.string(from: datePicker.date)
    }
    
    
    func updateLabels(){
               if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
               CLLocationManager.authorizationStatus() == .authorizedAlways) {
                let dateFormatter = DateFormatter()
                       dateFormatter.dateFormat = "MM/dd/yyyy"
                       var lon: String = longField.text!
                       var lat: String = latField.text!
                    longitude = Double(lon)
                    latitude = Double(lat)
                   var sunCalc = SwiftySuncalc()
                   sunDate = dateFormatter.date(from: pickDate.text!)
                   if (sunDate != nil){
                       sunDate = sunDate! + TimeInterval(TimeZone.current.secondsFromGMT())}
                   var sun = sunCalc.getTimes(date: sunDate!, lat: latitude!, lng: longitude!);
                   // sun is a Dictionary of type String : Date
                   // set Value to sunriseLabel
                   print(TimeZone.current.secondsFromGMT())
                   dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                   sunRiseLabel.text = dateFormatter.string(from: sun["sunrise"]!)
                   sunSetLabel.text = dateFormatter.string(from: sun["sunset"]!)
               }
    }
    
 /*   func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted

        let components = string.components(separatedBy: inverseSet)

        let filtered = components.joined(separator: "")

        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    } */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
