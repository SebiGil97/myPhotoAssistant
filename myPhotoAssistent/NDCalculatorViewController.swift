//
//  NDCalculatorViewController.swift
//  myPhotoAssistent
//
//  Created by Sebastian Gilhofer on 15.01.20.
//  Copyright © 2020 Sebastian Gilhofer. All rights reserved.
//

import UIKit

class NDCalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var timerButton: UIButton!
    
   

    
    var nd8Val : Double = 1
    var nd64Val : Double = 1
    var nd1000Val : Double = 1
    var ndCustVal : Double = 1
    var calcExpoTime : Double = 0
    var recExpoTime : Double = 1/200
    
    var defaultExpoTimeDic = [  "1/4000":1/4000,
                                "1/3200":1/3200,
                                "1/2500":1/2500,
                                "1/2000":1/2000,
                                "1/1600":1/1600,
                                "1/1250":1/1250,
                                "1/1000":1/1000,
                                "1/800":1/800,
                                "1/640":1/640,
                                "1/500":1/500,
                                "1/400":1/400,
                                "1/320":1/320,
                                "1/250":1/250,
                                "1/200":1/200,
                                "1/160":1/160,
                                "1/125":1/125,
                                "1/100":1/100,
                                "1/80":1/80,
                                "1/60":1/60,
                                "1/50":1/50,
                                "1/40":1/40,
                                "1/30":1/30,
                                "1/25":1/25,
                                "1/20":1/20,
                                "1/15":1/15,
                                "1/13":1/13,
                                "1/10":1/10,
                                "1/8":1/8,
                                "1/6":1/6,
                                "1/5":1/5,
                                "1/4":1/4,
                                "1/3":1/3,
                                "1/2.5":1/2.5,
                                "1/2":1/2,
                                "1/1,6":1/1.6,
                                "1/1.3":1/1.3,
                                "1":1,
                                "1.3":1.3,
                                "1.6":1.6,
                                "2":2,
                                "2.5":2.5,
                                "3":3,
                                "4":4,
                                "5":5,
                                "6":6,
                                "8":8,
                                "10":10,
                                "13":13,
                                "15":15,
                                "20":20,
                                "25":25,
                                "30":30] as [String : Double]

    
    let defaultExpoTime = ["1/4000","1/3200","1/2500","1/2000","1/1600","1/1250","1/1000","1/800","1/640","1/500","1/400","1/320","1/250","1/200","1/160","1/125","1/100","1/80","1/60","1/50","1/40","1/30","1/25","1/20","1/15","1/13","1/10","1/8","1/6","1/5","1/4","1/3","1/2.5","1/2","1/1.6","1/1.3","1","1.3","1.6","2","2.5","3","4","5","6","8","10","13","15","20","25","30"]
    
    
    
    @IBOutlet weak var calculetedTimeLable: UILabel!
    
    @IBOutlet weak var expoTimePicker: UIPickerView!
    
    @IBOutlet weak var customNDValTextfield: UITextField!
    
    //-----------------------------Switch-------------------------------
    //Switch ND8
    @IBOutlet weak var nd8Switch: UISwitch!
    
    @IBAction func nd8SwitchChanged(_ sender: Any) {
        if nd8Switch.isOn{
            nd8Val = 8
        }else{
            nd8Val = 1
        }
        
        calculateExpourseTime()
    }
    //Switch ND64
    
    @IBOutlet weak var nd64Switch: UISwitch!
    
    @IBAction func nd64SwitchChanged(_ sender: Any) {
        if nd64Switch.isOn{
            nd64Val = 64
        }else{
            nd64Val = 1
        }
        
        calculateExpourseTime()
    }
    
    //Switch ND1000
    @IBOutlet weak var nd1000Switch: UISwitch!
    
    @IBAction func nd1000SwitchChanged(_ sender: Any) {
        if nd1000Switch.isOn{
            nd1000Val = 1000
        }else{
            nd1000Val = 1
        }
        
        calculateExpourseTime()
    }
    
    //Switch Custom
    @IBOutlet weak var ndCustomSwitch: UISwitch!
    @IBAction func ndCustomSwitchChanged(_ sender: Any) {
        if ndCustomSwitch.isOn{
            //var x = customNDValTextfield.text
            let val: String = customNDValTextfield.text ?? "1"
            ndCustVal = Double(val) ?? 1
        }else{
            ndCustVal = 1
        }
        if(ndCustVal<1){
            
            ndCustVal = 1
            customNDValTextfield.text = ""
        }
        calculateExpourseTime()
        
    }
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.addDoneButtonOnKeyboard()
        self.expoTimePicker.delegate = self
        self.expoTimePicker.dataSource = self
        //set default Value for Picker
        expoTimePicker.selectRow(13, inComponent: 0, animated: true)
        timerButton.layer.cornerRadius = 15
        timerButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        timerButton.layer.shadowOffset = CGSize(width: 5.0, height: 4.0)
        timerButton.layer.shadowOpacity = 1.0
        timerButton.layer.shadowRadius = 2.0
        
        
        
        calculateExpourseTime()
    
        /*
        for time in defaultExpoTime{
            print("\""+time+"\""+":"+time+",")
        }*/
    }
    
    func calculateExpourseTime(){
        calcExpoTime = recExpoTime*nd8Val*nd64Val*nd1000Val*ndCustVal
        var prevString : String = ""
        var prevDouble : Double = 0
        if calcExpoTime < 31 {
            timerButton.isHidden = false //Just for test case!!!
            for val in defaultExpoTime{
                let cmprVal = defaultExpoTimeDic[val] ?? 0
                if(cmprVal >= calcExpoTime){
                    if(cmprVal-calcExpoTime < calcExpoTime - prevDouble){
                        calculetedTimeLable.text = val + "s"
                    }else{
                        calculetedTimeLable.text = prevString + "s"

                    }
                    return
                }
                prevString = val
                prevDouble = cmprVal
            }
        }else{
            timerButton.isHidden = false
            let calcExpoTimeInt = Int(calcExpoTime)
            let sec = calcExpoTimeInt%60
            let min = (calcExpoTimeInt/60)%60
            let hour = calcExpoTimeInt/3600
            
            calculetedTimeLable.text = String(hour) + "h" + " : " + String(min) + "min" + " : " + String(sec) + "s"

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
    
    //add Done Button to NumPad
   func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        customNDValTextfield.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        customNDValTextfield.resignFirstResponder()
        print("Done pressed")
        let val: String = customNDValTextfield.text ?? "1"
        if ndCustomSwitch.isOn{
               //var x = customNDValTextfield.text
          
           ndCustVal = Double(val) ?? 1
        }else{
              
                ndCustVal = 1
        }
        
        if(Double(val) ?? 0 < 1){
            
            ndCustVal = 1
            customNDValTextfield.text = ""
        }
               
        calculateExpourseTime()
    }
    
    //for ExpoTime Picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return defaultExpoTime.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return defaultExpoTime[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        recExpoTime = defaultExpoTimeDic[defaultExpoTime[row]] ?? 0
        calculateExpourseTime()

        //print(defaultExpoTime[row])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is TimerViewController{
            let vc = segue.destination as? TimerViewController
            vc?.time = calcExpoTime
        }
    }
}

/*
extension UIButton {
    
    func startAnimatingPressActions() {
        addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        addTarget(self, action: #selector(animateUp), for: [.touchDragExit, .touchCancel, .touchUpInside, .touchUpOutside])
    }
    
    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }
    
    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }
    
    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
                        button.transform = transform
            }, completion: nil)
    }
    
} */
