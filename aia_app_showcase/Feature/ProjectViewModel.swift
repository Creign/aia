//
//  ProjectViewModel.swift
//  aia_app_showcase
//
//  Created by Excell on 28/02/2021.
//

import Foundation

class ProjectViewModel {
    
    var apiKeys: [String] = ["G9V8Y16K2EW7MZHA", "G9V8Y16K2EW7MZHA"]
    var outputSizes: [String] = ["Compact", "Full"]
    var interval: [String] = ["1", "5", "15", "30", "60"]
}

// MARK: - Public Functions
extension ProjectViewModel {
    func getOutputSegmentLoadIndex() -> Int {
        for (index, size) in outputSizes.enumerated() {
            if Utils.getDefault(key: .outputSize).lowercased() == size.lowercased() {
                return index
            }
        }
        return 0
    }
    
    func getIntervalSegmentLoadIndex() -> Int {
        for (index, interval) in interval.enumerated() {
            if Utils.getDefault(key: .interval) == interval {
                return index
            }
        }
        return 0
    }
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


