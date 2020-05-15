//
//  FlightStatusService.swift
//  FinalProject
//
//  Created by KrishnaPriya, Parumanchala on 12/7/19.
//  Copyright © 2019 KrishnaPriya Parumanchala. All rights reserved.
//

import Foundation


class FlightStatusService
{
    struct FlightStatusByNumber {
        var departureAirport:String = ""
        var arrivalAirport:String = ""
        var departureTime:String = ""
        var arrivalTime:String = ""
        var departureFlightDelay:String = ""
        var arrivalFlightDelay:String = ""
        var departureGate:String = ""
        var arrivalGate:String = ""
    }
    
    let FlightStatusBaseURL: URL? = URL(string: "https://api.lufthansa.com/v1/operations/flightstatus")
    
    // https://api.lufthansa.com/v1/operations/flightstatus/LH2039/2019-12-09
    func getStatus(flightNumber: String, flightDate: String, completion: @escaping (FlightStatusByNumber?) -> Void)
    {
        
        
        if let flightStatusURL = URL(string: "\(FlightStatusBaseURL!)/\(flightNumber)/\(flightDate)") {
            do
            {
              
            let networkHandler = NetworkHandler(url: flightStatusURL)
            networkHandler.downloadJSONFromURL { (jsonDictionary) in
                
            //networkHandler.downloadJSONFromURL(jsonDictionary) in
            //TODO: Parse jsondICTIONARY into swift object.
            
            let dictionary = jsonDictionary! as? [String:Any]
            let FlightStatusResource = dictionary?["FlightStatusResource"] as! [String: AnyObject]
            let Flights = FlightStatusResource["Flights"]! as! [String: AnyObject]
            let Flight = Flights["Flight"]! as! [AnyObject]             //print(Flight)
            //let index = Flight.count
            let thisFlight = Flight[0]
            let Departure = thisFlight["Departure"]! as! [String: AnyObject]
            let Arrival = thisFlight["Arrival"]! as! [String: AnyObject]
                let departureAirport = Departure["AirportCode"]!
                let arrivalAirport = Arrival["AirportCode"]!
            print(departureAirport)
            print(arrivalAirport)
            let DepartureScheduledTimeLocal = Departure["ScheduledTimeLocal"]! as! [String: AnyObject]
            let ArrivalScheduledTimeLocal = Arrival["ScheduledTimeLocal"]! as! [String: AnyObject]
                let departureTime = DepartureScheduledTimeLocal["DateTime"]!
                let arrivalTime = ArrivalScheduledTimeLocal["DateTime"]!
            print(departureTime)
            print(arrivalTime)
            let departureTimeStatus = Departure["TimeStatus"]! as! [String: AnyObject]
            let ArrivalTimeStatus = Arrival["TimeStatus"]! as! [String: AnyObject]
                let departureFlightDelay = departureTimeStatus["Definition"]!
                let arrivalFlightDelay = ArrivalTimeStatus["Definition"]!
            print(departureFlightDelay)
            print(arrivalFlightDelay)
            let departureTerminal = Departure["Terminal"]! as! [String: AnyObject]
            let ArrivalTerminal = Arrival["Terminal"]! as! [String: AnyObject]
                let departureGate = departureTerminal["Gate"]!
                let arrivalGate = ArrivalTerminal["Name"]!
            print(departureGate)
            print(arrivalGate)
            
             var f = FlightStatusByNumber()
                f.departureAirport = departureAirport as! String
                f.arrivalAirport = arrivalAirport as! String
                f.departureTime = departureTime as! String
                f.arrivalTime = arrivalTime as! String
                f.departureFlightDelay = departureFlightDelay as! String
                f.arrivalFlightDelay = arrivalFlightDelay as! String
                f.departureGate = departureGate as! String
                f.arrivalGate = arrivalGate as! String
                print("Structure is" +  f.departureAirport)
                
                completion(f)
                
                
                
              
              // return f
                
                }
            }catch let error as NSError
                {
                    print("Error processing json data: \(error)")
                }
           
                }
        
             }
        }
    

