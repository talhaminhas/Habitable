//
//  TimeRepsController.swift
//  IslamicHT
//
//  Created by Minhax on 22/05/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit
class TimeRepsController: UITableViewController {

    
    @IBOutlet weak var timeRepsSection: UISegmentedControl!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var customSwitch: UISwitch!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var repsPicker: UIPickerView!
    var headersNames = ["","","Choose your time :","Choose your reps:" ,"",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repsPicker.delegate = self
        repsPicker.dataSource = self
        timePicker.delegate = self
        timePicker.dataSource = self
         title = "Time/Reps"
        
    }
    @IBAction func sectionChanged(_ sender: Any) {
        table.reloadData()
    }
    @IBAction func switchStateChanged(_ sender: UISwitch) {
        table.reloadData()
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = Bundle.main.loadNibNamed("TableHeader", owner: self, options: nil)?.first as! TableHeader
        headerView.headerLabel.text = headersNames[section]
        return headerView
    }


}
extension TimeRepsController : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if timeRepsSection.selectedSegmentIndex == 0{
            return 4
        }
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if timeRepsSection.selectedSegmentIndex == 0{
            switch component {
            case 0:
                return 1
            case 1:
                return 1000
            case 2:
                return 60
            default:
                return 1
            }
        }
        return 1000
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //label.text = datasource[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if timeRepsSection.selectedSegmentIndex == 0{
            switch component {
            case 0:
                return "Hours "
            case 1:
                return String(row)
            case 2:
                return String(row+1)
            default:
                return " Minutes"
            }
        }
        return String(row+1)
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 60))
        if timeRepsSection.selectedSegmentIndex == 0{
            switch component {
            case 0:
                label.text = " Hours"
            case 1:
                label.text = String(row)
            case 2:
                label.text = String(row+1)
            default:
                label.text = "Minutes "
            }
        }
        else{
            label.text = String(row+1)
        }
        label.textColor = UIColor.label
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name:"HelveticaNeue", size: 20.0)
        view.addSubview(label)
        return view
    }
}

extension TimeRepsController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if timeRepsSection.selectedSegmentIndex == 0 {
            if customSwitch.isOn == true{
                switch section {
                case 0:
                    return 0
                case 1:
                    return 0
                case 2:
                    return 60
                case 3:
                    return 0
                case 4:
                    return 20
                default:
                    return 0
                }
            }
            else{
                switch section {
                case 0:
                    return 20
                case 1:
                    return 0
                case 2:
                    return 0
                case 3:
                    return 0
                case 4:
                    return 20
                default:
                    return 0
                }
            }
        }
        else{
            if customSwitch.isOn == true{
                switch section {
                case 0:
                    return 0
                case 1:
                    return 0
                case 2:
                    return 0
                case 3:
                    return 60
                case 4:
                    return 20
                default:
                    return 0
                }
            }
            else{
                switch section {
                case 0:
                    return 0
                case 1:
                    return 20
                case 2:
                    return 0
                case 3:
                    return 0
                case 4:
                    return 20
                default:
                    return 0
                }
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if timeRepsSection.selectedSegmentIndex == 0 {
            if customSwitch.isOn == true{
                switch section {
                case 0:
                    return 0
                case 1:
                    return 0
                case 2:
                    return 1
                case 3:
                    return 0
                case 4:
                    return 1
                default:
                    return 0
                }
            }
            else{
                switch section {
                case 0:
                    return 5
                case 1:
                    return 0
                case 2:
                    return 0
                case 3:
                    return 0
                case 4:
                    return 1
                default:
                    return 0
                }
            }
        }
        else{
            if customSwitch.isOn == true{
                switch section {
                case 0:
                    return 0
                case 1:
                    return 0
                case 2:
                    return 0
                case 3:
                    return 1
                case 4:
                    return 1
                default:
                    return 0
                }
            }
            else{
                switch section {
                case 0:
                    return 0
                case 1:
                    return 5
                case 2:
                    return 0
                case 3:
                    return 0
                case 4:
                    return 1
                default:
                    return 0
                }
            }
        }
    }
}
