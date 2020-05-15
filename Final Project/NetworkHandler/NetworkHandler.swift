//
//  NetworkHandler.swift
//  Flighty_Nameless
//
//  Created by KrishnaPriya, Parumanchala on 10/25/19.
//  Copyright © 2019 KrishnaPriya, Parumanchala. All rights reserved.
//

import Foundation
var errorResponseCode=0
class NetworkHandler
{
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    //lazy var session: URLSession = URLSession(configuration: URLSessionConfiguration)
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    
    let url: URL
    
    init(url: URL)
    {
        self.url = url
    }
    
    typealias JSONDictionaryHandler = (([String : Any]?) -> Void)
    
    func downloadJSONFromURL(_ completion: @escaping JSONDictionaryHandler)
    {
        var request = URLRequest(url: self.url)
        
        request.setValue("Bearer sj39hpgxmw9f9jdtm5ns322b", forHTTPHeaderField: "Authorization")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")      // the expected response is also JSON
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if error == nil
            {
                if let httpResponse = response as? HTTPURLResponse
                {
                    switch httpResponse.statusCode
                    {
                    case 200:
                        //TODO
                        if let data = data
                        {
                            do
                            {
                            let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)

                            completion(jsonDictionary as? [String : Any])
                            // print(data)

                            } catch let error as NSError
                            {
                            print("Error processing json data: \(error.localizedDescription)")
                            }
                        }

                    default:
                        print("HTTP Response error response code: \(httpResponse.statusCode)")
                        errorResponseCode=httpResponse.statusCode
                        print(errorResponseCode)
                    }
                }
                
            }
            else
            {
                print("Error: \(error?.localizedDescription)")
            }
            
        }
        dataTask.resume()
    }
}
    
