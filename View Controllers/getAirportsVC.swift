//
//  getAirportsVC.swift
//  FinalProject
//
//  Created by KrishnaPriya, Parumanchala on 10/26/19.
//  Copyright © 2019 KrishnaPriya Parumanchala. All rights reserved.
//

import UIKit

class getAirportsVC: UIViewController,UITextFieldDelegate {
    var localErrorResponseCode=1
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var lblToThrowErrors: UILabel!
    @IBOutlet weak var lblView2: UITextView!
    @IBOutlet weak var lblView: UITextView!
    @IBOutlet weak var lblLong: UITextField!
    @IBOutlet weak var lblLat: UITextField!
    override func viewDidLoad() {
        lblLat.becomeFirstResponder()
        super.viewDidLoad()
        btnSearch.applyDesign()
        let backgroundImage = UIImage.init(named: "FlightImage.jpg")
        let backgroundImageView = UIImageView.init(frame: self.view.frame)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.5
        self.view.insertSubview(backgroundImageView, at: 0)
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSearchForAirports(_ sender: Any) {
        if localErrorResponseCode != 0{
            //print(1)
            self.lblToThrowErrors.isHidden=false
            self.lblToThrowErrors.text=nil
            self.lblToThrowErrors.text="*Invalid data/Network Issues"
        }
        if lblLat.text?.count==0 || lblLong.text?.count==0
        {
            lblToThrowErrors.isHidden=false
            lblToThrowErrors.text="*One or more Fields are missing"
        }
        else{
        let flightStatus = GetAirportsWithGPS()
        
        flightStatus.getNearestAiport(latitude: lblLat.text!,
                                      longitude: lblLong.text!)
            {(AirportCodeStruct) in
             DispatchQueue.main.async {
                self.localErrorResponseCode=0
                self.lblToThrowErrors.text=nil
                
                let temp = " 1. " + (AirportCodeStruct!.Array[1]) + "\n 2. " + (AirportCodeStruct!.Array[2])
                let temp1 = "\n 3. " + (AirportCodeStruct!.Array[3]) + "\n 4. " + (AirportCodeStruct!.Array[4])
                let temp2 = "\n 5. " + (AirportCodeStruct!.Array[5] )
                self.lblView.text = temp + temp1 + temp2
                
                let temp3 = " 1. " + (AirportCodeStruct!.Cities[1]) + "\n 2. " + (AirportCodeStruct!.Cities[2])
                let temp4 = "\n 3. " + (AirportCodeStruct!.Cities[3]) + "\n 4. " + (AirportCodeStruct!.Cities[4])
                let temp5 = "\n 5. " + (AirportCodeStruct!.Cities[5] )
                self.lblView2.text = temp3 + temp4 + temp5
                
                
                //self.lblView.text="Airport-City\n1.\(AirportCodeStruct?.Array[1])-\(AirportCodeStruct?.Cities[1])"
        
        
       // performSegue(withIdentifier: "getAirportsVCToResultsVC", sender: self)
    }
        }
    }
}
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
     lblLat.resignFirstResponder()
        lblLong.resignFirstResponder()
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
