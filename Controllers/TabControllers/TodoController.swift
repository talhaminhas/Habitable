//
//  TodoController.swift
//  IslamicHT
//
//  Created by Minhax on 15/05/2020.
//  Copyright © 2020 Talha. All rights reserved.
//

import UIKit
import DateScrollPicker
import RealmSwift
class TodoController: UIViewController {

    @IBOutlet weak var datePicker: DateScrollPicker!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var contentView: UIView!
    let realm = try! Realm()
    var oneTimeTask = true
    let dataSource = [ "Ongoing","Compeleted", "Late","Missed"]
    var currentViewControllerIndex : Int = 0
    var format = DateScrollPickerFormat()
    let pickerViewLabelHeight : CGFloat = 100
    let pickerViewLabelWidth : CGFloat = 100
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "TO DO"
        pickerView.delegate = self
        pickerView.dataSource = self
        let y1 = pickerView.frame.origin.y
        pickerView.transform = CGAffineTransform(rotationAngle: -90 * (.pi/180))
        pickerView.frame = CGRect(x: -100, y: y1, width: view.frame.width+200, height: 40)
        configurePageViewController()
        setFormat()
        datePicker.format = format
    }
    override func viewDidAppear(_ animated: Bool) {
        if oneTimeTask{
            oneTimeTask = false
            datePicker.selectToday(animated: true)
        }
        
        
    }
    func setFormat(){
        format.days = 5
        format.topTextColor = UIColor.label
        format.topDateFormat = "EEE"
        format.topFont = UIFont.systemFont(ofSize: 8, weight: .regular)
        format.topTextSelectedColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        format.mediumDateFormat = "dd"
        format.mediumFont = UIFont.systemFont(ofSize: 28, weight: .regular)
        format.mediumTextColor = UIColor.label
        format.mediumTextSelectedColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        format.bottomDateFormat = "MMM"
        format.bottomFont = UIFont.systemFont(ofSize: 8, weight: .regular)
        format.bottomTextColor = UIColor.label
        format.bottomTextSelectedColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //format.dayRadius: CGFloat = 5
        format.dayBackgroundColor = UIColor(named: "BarColor")!
        format.dayBackgroundSelectedColor = UIColor(named: "BrandColor")!
        format.animatedSelection = true
        format.separatorEnabled = true
        format.separatorTopDateFormat = "MMM"
        format.separatorTopFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        format.separatorTopTextColor = UIColor(named: "BrandColor")!
        format.separatorBottomDateFormat = "yyyy"
        format.separatorBottomFont = UIFont.systemFont(ofSize: 15, weight: .regular)
        format.separatorBottomTextColor = UIColor(named: "BrandColor")!
        format.separatorBackgroundColor = #colorLiteral(red: 0.1098428294, green: 0.1097317412, blue: 0.1140908971, alpha: 1)
        format.fadeEnabled = true
        //format.animationScaleFactor: CGFloat = 1.1
        //format.dayPadding: CGFloat = 5
        //format.topMarginData: CGFloat = 10
        //format.dotWidth: CGFloat = 10
    
    }
    func configurePageViewController(){
        guard let pageViewController = storyboard?.instantiateViewController(withIdentifier: String(describing: CustomPageViewController.self)) as? CustomPageViewController else {
            return
        }
        pageViewController.delegate = self
        pageViewController.dataSource = self
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(pageViewController.view)
        let views: [String : Any] = ["pageView" : pageViewController.view as Any]
        contentView.addConstraints(NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-0-[pageView]-0-|",
            options: NSLayoutConstraint.FormatOptions(rawValue: 0),
            metrics: nil,
            views: views))
        contentView.addConstraints(NSLayoutConstraint.constraints(
        withVisualFormat: "V:|-0-[pageView]-0-|",
        options: NSLayoutConstraint.FormatOptions(rawValue : 0),
        metrics: nil,
        views: views))
        
        guard let startingViewController = detailViewControllerAt(index: currentViewControllerIndex) else {
            return
        }
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: true)
    }
    func detailViewControllerAt(index : Int)-> OngoingController?{
        
        if index >= dataSource.count || dataSource.count == 0{
            return nil
        }
        guard let dataViewController = storyboard?.instantiateViewController(withIdentifier: String (describing: OngoingController.self)) as? OngoingController else {
            
            return nil
        }
        dataViewController.index = index
        dataViewController.displayString = dataSource[index]
        dataViewController.pickerView = self.pickerView
        dataViewController.datePicker = self.datePicker
        return dataViewController
    }
   

}
extension TodoController : UIPageViewControllerDelegate,UIPageViewControllerDataSource{
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentViewControllerIndex
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return dataSource.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? OngoingController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        currentViewControllerIndex = currentIndex
        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        return detailViewControllerAt(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let dataViewController = viewController as? OngoingController
        
        guard var currentIndex = dataViewController?.index else {
            return nil
        }
        if currentIndex == dataSource.count{
            return nil
        }
        currentIndex += 1
        currentViewControllerIndex = currentIndex
        return detailViewControllerAt(index: currentIndex)
    }
}
extension TodoController : UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //label.text = datasource[row]
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerViewLabelHeight
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        label.text = dataSource[row]
        label.textColor = UIColor.label
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont(name:"HelveticaNeue-Bold", size: 17.0)
        view.addSubview(label)
        view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))
        return view
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for i in [1] {
            pickerView.subviews[i].isHidden = true
        }
    }
}

