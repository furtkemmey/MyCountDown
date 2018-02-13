//
//  ViewController.swift
//  MyCountDown
//
//  Created by KaiChieh on 13/02/2018.
//  Copyright © 2018 KaiChieh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let hours = ["hours", "3", "2", "1", "0"]
    var minutes = [String]()
    var sec = [String]()
    var selectedHourIndex = 1
    var selectedMinIndex = 1
    var selectedSecondIndex = 1
    var coundDownInSec = 0

    //MARK: - IBOutlet
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var leftTime: UILabel!
    @IBOutlet weak var pickerViewCountDown: UIPickerView!

    @IBAction func startButton(_ sender: UIButton) {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.leftTime.text = "Left time \(self.coundDownInSec)"
            print(self.coundDownInSec)
            self.coundDownInSec -= 1
            if self.coundDownInSec < 0 {
                timer.invalidate()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...59 {
            if i == 0 {
                minutes.append("min")
                sec.append("sec")
            }
            minutes.append("\(i)")
            sec.append("\(i)")
        }
        pickerViewCountDown.delegate = self
        pickerViewCountDown.dataSource = self
        for j in 0...2 {
            pickerViewCountDown.selectRow(1, inComponent: j, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return hours.count
        case 1:
            return minutes.count
        case 2:
            return sec.count
        default:
            return 0
        }
    }
    
    //MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return hours[row]
        case 1:
            return minutes[row]
        case 2:
            return sec[row]
        default:
            return ""
        }
    }
    var totalSecond: Int {
        var show = (Int(hours[selectedHourIndex])! * 3600) + (Int(minutes[selectedMinIndex])! * 60) + (Int(sec[selectedSecondIndex])!)
//       totalTime.text = "\(show)"
        return show
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedHourIndex = row
        case 1:
            selectedMinIndex = row
        case 2:
            selectedSecondIndex = row
        default:
            break
        }
        coundDownInSec = totalSecond
        totalTime.text = "Total time \(coundDownInSec)"
    }

}

