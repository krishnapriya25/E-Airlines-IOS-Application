//
//  flightSearchByArrivalAirportVC.swift
//  FinalProject
//
//  Created by KrishnaPriya, Parumanchala on 10/27/19.
//  Copyright © 2019 KrishnaPriya Parumanchala. All rights reserved.
//

import UIKit

class flightSearchByArrivalAirportVC: UIViewController,UITextFieldDelegate {
var localErrorResponseCode=1
    @IBOutlet weak var lblToThrowErrors: UILabel!
    @IBOutlet weak var txtArrAirport: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtArrDate: UITextField!
    private var datePicker: UIDatePicker?
    
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var lblArrFlights: UITextView!
    @IBOutlet weak var txtTime: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSearch.applyDesign()
        txtArrAirport.becomeFirstResponder()
        let backgroundImage = UIImage.init(named: "FlightImage.jpg")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.5
        self.view.insertSubview(backgroundImageView, at: 0)
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flightSearchByNumberVC.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
        txtArrDate.inputView = datePicker
        // Do any additional setup after loading the view.
    }
    //var DateTime:String =
    
    @IBAction func btnSearchByArrivalAirport(_ sender: Any) {
        if localErrorResponseCode != 0{
            //print(1)
            self.lblToThrowErrors.isHidden=false
            self.lblToThrowErrors.text=nil
            self.lblToThrowErrors.text="*Invalid data/Network Issues"
        }
        if txtArrAirport.text?.count==0 || txtArrDate.text?.count==0 || txtTime.text?.count==0
        {
            lblToThrowErrors.isHidden=false
            lblToThrowErrors.text="*One or more Fields are Missing"
        }
        else
        {
        let DateTime:String = txtArrDate.text! + "T" + txtTime.text!
        print(DateTime)
        let flightStatus = FlightStatusByArrival()
        struct FlightArrivals {
            var list:[String] = [""]
        }
        var g = FlightArrivals()
        flightStatus.getStatus(IATA_Airport: txtArrAirport.text!, dateTime: DateTime) {(FlightStatusByArrivalStruct) in
            DispatchQueue.main.async {
                self.localErrorResponseCode=0
                self.lblToThrowErrors.text=nil
                self.txtLbl.text = "All flights arriving to " + (self.txtArrAirport.text!) + " in next 5 hrs are listed below:"
                let f = FlightStatusByArrivalStruct
                let fCount = f.count
                //print(f)
                for index in 0..<fCount{
                    g.list.append(f[index].flightNumber)
                }
                var temp = ""
                for index in 1..<g.list.count
                {
                    if index <= g.list.count && g.list[index] != nil
                    {
                        temp =  temp + "\n" + (String(index)) + ". " + g.list[index] + " "
                        //print(temp)
                    }
                }
                print(temp)
                self.lblArrFlights.text = temp
                //self.lblDepAirport.text = FlightStatusByNumber?.departureAirport
            }
        
        
        }
        
        //performSegue(withIdentifier: "flightSearchByArrivalAirportVCToResultsVC", sender: self)
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
           
           txtArrDate.text = dateFormatter.string(from: datePicker.date)
           view.endEditing(true)
            
           
       }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
     txtArrAirport.resignFirstResponder()
        txtTime.resignFirstResponder()
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
