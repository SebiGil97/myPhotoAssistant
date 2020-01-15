//
//  NDCalculatorViewController.swift
//  myPhotoAssistent
//
//  Created by Sebastian Gilhofer on 15.01.20.
//  Copyright © 2020 Sebastian Gilhofer. All rights reserved.
//

import UIKit

class NDCalculatorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    var nd8Val = 1
    var nd64Val = 1
    var nd1000Val = 1
    var ndCustVal = 1
    var calcExpoTime = 0
    
    let defaultExpoTime = ["1/4000","1/3200","1/2500","1/2000","1/1600","1/1250","1/1000","1/800","1/640","1/500","1/400","1/320","1/250","1/200","1/160","1/125","1/100","1/80","1/60","1/50","1/40","1/30","1/25","1/20","1/15","1/13","1/10","1/8","1/6","1/5","1/4","1/3","1/2.5","1/2","1/1,6","1/1.3","1","1.3","1.6","2","2.5","3","4","5","6","8","10","13","15","20","25","30"]
    
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
            //ndCustVal = Int(x ?? 1)
        }else{
            ndCustVal = 1
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

        calculateExpourseTime()
    }
    
    func calculateExpourseTime(){
    
        calculetedTimeLable.text = String(nd8Val*nd64Val*nd1000Val*ndCustVal)
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
        print(defaultExpoTime[row])
    }
}
