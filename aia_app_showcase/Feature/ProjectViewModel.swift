//
//  ProjectViewModel.swift
//  aia_app_showcase
//
//  Created by Excell on 28/02/2021.
//

import Foundation

class ProjectViewModel {
    
    var apiKey = "G9V8Y16K2EW7MZHA"
    
    
}

// MARK: - API
extension ProjectViewModel {
    func timeSeriesIntraday() {
        let url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&apikey=demo"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response ?? "")
            do {
//                let json = (try? JSONSerialization.jsonObject(with: data!)).flatMap{ $0 as? [String: Any] }
                let json = try! JSONDecoder().decode(DecodedArray<TimeSeriesIntradayDataType>.self, from: data!)
                print(json)
            } catch {
                print("error")
            }
        }.resume()
    }
    
    func timeSeriesDailyAdjusted() {
        let url = "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY_ADJUSTED&symbol=IBM&apikey=demo"
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response ?? "")
            
            
            
        }.resume()
    }
}


