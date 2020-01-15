//
//  TimerViewController.swift
//  myPhotoAssistent
//
//  Created by Sebastian Gilhofer on 15.01.20.
//  Copyright © 2020 Sebastian Gilhofer. All rights reserved.
//

import UIKit
import AudioToolbox


class TimerViewController: UIViewController {
    

    var sec = 0
    var hour = 0
    var min = 0
    
    var timer:Timer?
    var timeLeft = 60
    

    @IBOutlet weak var timerDisplay: UILabel!
    
    var time : Double = 0
    
    @IBOutlet weak var startbutton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func startPressed(_ sender: Any) {
        timeLeft = sec + min * 60 + hour * 60 * 60
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(onTimerFires), userInfo: nil, repeats: true)
    }
    
    @objc func onTimerFires()
    {
        timeLeft -= 1
        calcNewTime()
        printTime()
        //timerDisplay.text = "\(timeLeft) seconds left"
    
        if timeLeft <= 0 {
            timer!.invalidate()
            timer = nil
            for _ in 0...5{
                
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
            }
            
        }
    }
    
    @IBAction func resetPressed(_ sender: Any) {
        timer?.invalidate()
        timer = nil
        resetTimer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //make Buttons beautiful
        startbutton.layer.cornerRadius = 15
        startbutton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        startbutton.layer.shadowOffset = CGSize(width: 5.0, height: 4.0)
        startbutton.layer.shadowOpacity = 1.0
        startbutton.layer.shadowRadius = 2.0
        
        resetButton.layer.cornerRadius = 15
        resetButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        resetButton.layer.shadowOffset = CGSize(width: 5.0, height: 4.0)
        resetButton.layer.shadowOpacity = 1.0
        resetButton.layer.shadowRadius = 2.0
        // Do any additional setup after loading the view.
        
        resetTimer()
      
    }
    
    
    
    func resetTimer(){
        let calcExpoTimeInt = Int(time)
        sec = calcExpoTimeInt%60
        min = (calcExpoTimeInt/60)%60
        hour = calcExpoTimeInt/3600
        
        printTime()
    }
    
    func printTime(){
        
        timerDisplay.text = String(hour) + " : " + String(min) + " : " + String(sec)
    }
    
    func calcNewTime(){
        if(sec==0){
           
            sec = 59
            if(min==0){
                if(hour != 0){
                    hour = hour - 1
                    min = 59
                }
            }else{
                min = min - 1
            }
        }else{
            sec = sec - 1
        }
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


