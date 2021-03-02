//
//  Enums.swift
//  aia_app_showcase
//
//  Created by Excell on 02/03/2021.
//

import Foundation

public enum StockFunctions: String {
    case timeSeriesIntraday = "TIME_SERIES_INTRADAY"
    case timeSeriesDailyAdjusted = "TIME_SERIES_DAILY_ADJUSTED"
}

public enum StockSymbols: String {
    case ibm = "IBM (United States)"
    case tesco = "Tesco PLC (UK - London Stock Exchange)"
    case shopify = "Shopify Inc (Canada - Toronto Stock Exchange)"
    case greenPower = "GreenPower Motor Company Inc (Canada - Toronto Venture Exchange)"
    case daimler = "Daimler AG (Germany - XETRA)"
    case reliance = "Reliance Industries Limited (India - BSE)"
    case saic = "SAIC Motor Corporation (China - Shanghai Stock Exchange)"
    case vanke = "China Vanke Company Ltd (China - Shenzhen Stock Exchange)"
    
    var code: String {
        switch self {
        case .ibm:
            return "IBM"
        case .tesco:
            return "TSCO.LON"
        case .shopify:
            return "SHOP.TRT"
        case .greenPower:
            return "GPV.TRV"
        case .daimler:
            return "DAI.DEX"
        case .reliance:
            return "RELIANCE.BSE"
        case .saic:
            return "600104.SHH"
        case .vanke:
            return "000002.SHZ"
        }
    }
}


public enum UserDefaultTypes: String {
    case outputSize = "outputSize"
    case interval = "interval"
    case apiKey = "apiKey"
}

public enum OutputSizeType: String {
    case compact = "compact"
    case full = "full"
}

//public enum KeychainTypes: String {
//    case apiKeys = "apiKeys"
//}
