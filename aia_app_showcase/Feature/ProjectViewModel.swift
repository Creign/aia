//
//  ProjectViewModel.swift
//  aia_app_showcase
//
//  Created by Excell on 28/02/2021.
//

import Foundation

class ProjectViewModel {
    
    let apiKeys: [String] = ["G9V8Y16K2EW7MZHA", "demo"]
    let outputSizes: [String] = ["Compact", "Full"]
    let interval: [String] = ["1", "5", "15", "30", "60"]
    
    var currentIntervalKey: String = ""
    var timeSeriesIntradayStock: Stock?
    var timeSeriesKeyValue: [String] = []
    
    var timeSeriesDailyStock: StockDaily?
    var timeSeriesDailyKeyValue: [String] = []
    
    // MARK: - Bindings
    var getIntradayError: ((String) -> Void)?
    var getIntradaySuccess: (() -> Void)?
    
    var getDailyError: ((String) -> Void)?
    var getDailySuccess: (() -> Void)?
    
}

// MARK: - Public Functions
extension ProjectViewModel {
    func getOutputSegmentLoadIndex() -> Int {
        guard let defaultsSize = Utils.getDefault(key: .outputSize)?.lowercased() else { return 0 }
        for (index, size) in outputSizes.enumerated() {
            if defaultsSize == size.lowercased() {
                return index
            }
        }
        return 0
    }
    
    func getIntervalSegmentLoadIndex() -> Int {
        guard let defaultsInterval = Utils.getDefault(key: .interval) else {
            self.currentIntervalKey = "Time Series (1min)"
            return 0
        }
        
        self.currentIntervalKey = "Time Series (\(defaultsInterval)min)"
        for (index, interval) in interval.enumerated() {
            if defaultsInterval == interval {
                return index
            }
        }
        return 0
    }
    
    func getApiKeyIndex() -> Int {
        guard let defaultsKey = Utils.getDefault(key: .apiKey)?.lowercased() else { return 0 }
        for (index, key) in apiKeys.enumerated() {
            if defaultsKey == key.lowercased() {
                return index
            }
        }
        return 0
    }
}

// MARK: - Private Fucntions
private extension ProjectViewModel {
    func getURL(function: StockFunctions, symbol: String) -> String {
        let apiKey = apiKeys[0]
        let functionStr = function.rawValue
        let interval = "\(Utils.getDefault(key: .interval) ?? "1")min"
        let outputSize = Utils.getDefault(key: .outputSize)
        let str = "https://www.alphavantage.co/query?function=\(functionStr)&symbol=\(symbol)&interval=\(interval)&outputsize=\(outputSize ?? "")&apikey=\(apiKey)"
        
        return str
    }
}

// MARK: - API
extension ProjectViewModel {
    func timeSeriesIntraday(symbol: String) {
        let url = getURL(function: .timeSeriesIntraday, symbol: symbol)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
//                let json = (try? JSONSerialization.jsonObject(with: data!)).flatMap{ $0 as? [String: Any] }
//                let json = try? JSONDecoder().decode(DecodedArray<TimeSeriesIntradayDataType>.self, from: data!)
                let stock = try! JSONDecoder().decode(Stock.self, from: data!)
                    self.timeSeriesIntradayStock = stock
                self.timeSeriesKeyValue.append(contentsOf: stock.timeSeries.keys)
                self.getIntradaySuccess?()
            } catch {
                self.getIntradayError?(error.localizedDescription)
            }
        }.resume()
    }
    
    func timeSeriesDailyAdjusted(symbol: String) {
        let url = getURL(function: .timeSeriesDailyAdjusted, symbol: symbol)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(response ?? "")
            do {
                let stock = try! JSONDecoder().decode(StockDaily.self, from: data!)
                self.timeSeriesDailyStock = stock
                self.timeSeriesDailyKeyValue.append(contentsOf: stock.timeSeries.keys)
                self.getDailySuccess?()
            } catch {
                self.getDailyError?(error.localizedDescription)
            }
        }.resume()
    }
}


