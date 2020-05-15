//
//  searchForFlightsVC.swift
//  FinalProject
//
//  Created by KrishnaPriya, Parumanchala on 10/26/19.
//  Copyright © 2019 KrishnaPriya Parumanchala. All rights reserved.
//

import UIKit
var departureAirport1=""
var arrivalAirport1=""
var date1=""
class searchForFlightsVC: UIViewController,UITextFieldDelegate {
    private var datePicker: UIDatePicker?
    var localErrorResponseCode=1
    @IBOutlet weak var lblToThrowErrors: UILabel!
    @IBOutlet weak var txtDepartureAirport: UITextField!
    
    @IBOutlet weak var txtArrivalAirport: UITextField!
    
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtDepartureAirport.becomeFirstResponder()
        btnSearch.applyDesign()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
               
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flightSearchByNumberVC.viewTapped(gestureRecognizer:)))
               
        view.addGestureRecognizer(tapGesture)
               
        txtDate.inputView = datePicker
        let backgroundImage = UIImage.init(named: "FlightImage.jpg")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.5
        self.view.insertSubview(backgroundImageView, at: 0)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSearchForFlights(_ sender: Any) {
        
        if txtDepartureAirport.text?.count==0 || txtArrivalAirport.text?.count==0 || txtDate.text?.count==0
        {
            lblToThrowErrors.isHidden=false
            lblToThrowErrors.text="*One or more Fields are Missing"
        }
        else{
            
        departureAirport1=txtDepartureAirport.text!
        arrivalAirport1=txtArrivalAirport.text!
        date1=txtDate.text!
        
        performSegue(withIdentifier: "searchForFlightsVCToResultsVC", sender: self)
    }
}
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer)
       {
           view.endEditing(true)
       }
       @objc func dateChanged(datePicker: UIDatePicker)
       {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           
           txtDate.text = dateFormatter.string(from: datePicker.date)
           view.endEditing(true)
           
       }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        txtDepartureAirport.resignFirstResponder()
       txtArrivalAirport.resignFirstResponder()
        return true
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
