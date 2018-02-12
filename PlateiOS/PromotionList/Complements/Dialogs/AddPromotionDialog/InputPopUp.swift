//
//  InputPopUp.swift
//  PlateiOS
//
//  Created by Renner Leite Lucena on 1/8/18.
//  Copyright © 2018 Renner Leite Lucena. All rights reserved.
//

import UIKit

class InputPopUp: UIView {
    
    @IBOutlet weak var title: UITextField! {
        didSet {
            let contentView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: 20))
            
            title.clearsOnBeginEditing = false
            title.delegate = self
            title.leftViewMode = UITextFieldViewMode.always
            title.leftView = contentView
        }
    }
    
    @IBOutlet weak var startTime: UITextField! {
        didSet {
            
            
            let contentView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: 20))
            
            startTime.clearsOnBeginEditing = false
            startTime.delegate = self
            startTime.leftViewMode = UITextFieldViewMode.always
            startTime.leftView = contentView
        }
    }
    
    @IBOutlet weak var endTime: UITextField! {
        didSet {
            let contentView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: 20))
            
            endTime.clearsOnBeginEditing = false
            endTime.delegate = self
            endTime.leftViewMode = UITextFieldViewMode.always
            endTime.leftView = contentView
        }
    }
    
    @IBOutlet weak var location: UITextField! {
        didSet {
            let contentView = UIView(frame: CGRect(x: 10, y: 0, width: 10, height: 20))
            
            location.clearsOnBeginEditing = false
            location.delegate = self
            location.leftViewMode = UITextFieldViewMode.always
            location.leftView = contentView
        }
    }
    
    @IBAction func negativeClicked(_ sender: Any) {
        negativeFunction?()
    }
    
    @IBAction func positiveClicked(_ sender: Any) {
        if(title.text! == "" || startTime.text! == "" || endTime.text! == "" || location.text! == "") {
            errorFunction?()
            return
        }
        
        // Current format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM-dd h:mm a"
        
        // Get strings and put them on date objects
        var dateObjectStart = dateFormatter.date(from: startTime.text!)
        var dateObjectEnd = dateFormatter.date(from: endTime.text!)
        
        // All of this to get the current year
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        
        // This is to get the right difference in years between the start/end and current times.
        let componentsStart = calendar.dateComponents([.year], from: dateObjectStart!)
        let yearStart =  componentsStart.year!

        let componentsEnd = calendar.dateComponents([.year], from: dateObjectEnd!)
        let yearEnd =  componentsEnd.year!
        
        // Differences of years components.
        var startYearDifference = DateComponents()
        startYearDifference.year = currentYear - yearStart
        
        var endYearDifference = DateComponents()
        endYearDifference.year = currentYear - yearEnd
        
        // We finally add such differences to the respective dates, making them right.
        dateObjectStart = Calendar.current.date(byAdding: startYearDifference, to: dateObjectStart!)
        dateObjectEnd = Calendar.current.date(byAdding: endYearDifference, to: dateObjectEnd!)
        
        // Change the format
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // Output strings on new format
        let startTimeString = dateFormatter.string(from: dateObjectStart!)
        let endTimeString = dateFormatter.string(from: dateObjectEnd!)
        
        let promotionModel = PromotionModel(promotion_id: "", title: title.text!, start_time: startTimeString, end_time: endTimeString, location: location.text!)
        positiveFunction?(promotionModel)
    }
    
    @IBOutlet weak var negativeButton: UIButton! {
        didSet {
            negativeButton.setTitleColor(PlateColors.darkerGray, for: .normal)
        }
    }
    
    @IBOutlet weak var positiveButton: UIButton! {
        didSet {
            positiveButton.setTitleColor(PlateColors.mainBlue, for: .normal)
        }
    }
    
    let datePickerStart = UIDatePicker()
    let datePickerEnd = UIDatePicker()
    
    var negativeFunction: (() -> Void)?
    var positiveFunction: ((PromotionModel) -> Void)?
    var errorFunction: (() -> Void)?
    
    var textFieldDidBeginEditingFunction: (() -> Void)?
    var textFieldDidEndEditingFunction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 4
        clipsToBounds = true
        
        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let currentDate: Date = Date()
        let minDate: Date = currentDate
        
        let components: NSDateComponents = NSDateComponents()
        components.day = 30
        let maxDate: Date = gregorian.date(byAdding: components as DateComponents, to: currentDate, options: NSCalendar.Options(rawValue: 0))!
        
        self.datePickerStart.minimumDate = minDate
        self.datePickerStart.maximumDate = maxDate
    }
}

extension InputPopUp: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == startTime || textField == endTime) {
            showDatePicker(textField: textField)
        }
        textFieldDidBeginEditingFunction?()
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == startTime || textField == endTime) {
            showDatePicker(textField: textField)
        }
        textFieldDidEndEditingFunction?()
    }
}

extension InputPopUp {
    
    func showDatePicker(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        textField.inputAccessoryView = toolbar
        
        if(textField == startTime) {
            textField.inputView = datePickerStart
        }else {
            textField.inputView = datePickerEnd
        }
    }
    
    @objc func donePressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM-dd h:mm a"
        
        if(startTime.isFirstResponder) {
            startTime.text = dateFormatter.string(from: datePickerStart.date)
            
            let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
            let components: NSDateComponents = NSDateComponents()
            
            let minDate: Date = datePickerStart.date
            
            components.day = 7
            let maxDate: Date = gregorian.date(byAdding: components as DateComponents, to: datePickerStart.date, options: NSCalendar.Options(rawValue: 0))!
            
            self.datePickerEnd.minimumDate = minDate
            self.datePickerEnd.maximumDate = maxDate
            
        }else {
            endTime.text = dateFormatter.string(from: datePickerEnd.date)
        }
        
        textFieldDidEndEditingFunction?()
    }
}

