//
//  String+Extension.swift
//  OdiloApp
//
//  Created by Jorge Sánchez Coriasso on 13/4/21.
//  Copyright © 2021 Odilo. All rights reserved.
//

import Foundation


extension String {
    
    /**
    Transform miliseconds passed since 1970 to the date string that it represents
     
     - Parameter format: Change the desired format of the returned date
     
     - Returns: Formatted date with
     
     */
    func formatFromDate(withFormat format: String = "dd MMM, yyyy HH:MM:SS") -> String {
        
        guard let doubleValue = Double(self) else {
            return "---"
        }
        
        let dateFormatter = DateFormatter()
        let currenLanguage = LanguageManagerSwift.currentLanguageString()
        
        /// Chinense language exception
        if currenLanguage == "zh-Hans" {

            let date =  Date(timeIntervalSince1970: TimeInterval(doubleValue / 1000))
            //Set<Calendar.component>
            let dateComponets: DateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)
            return "\(dateComponets.day ?? 01)日 \(dateComponets.month ?? 01)月 \(dateComponets.year ?? 01)年 上午\(dateComponets.hour ?? 01):\(dateComponets.minute ?? 01)"
        }
        
        /// When using dutch language we replace the time separator, from ":" to "."
        let localizedFormat = currenLanguage == "nl" ? format.replacingOccurrences(of: ":", with: ".") : format
        dateFormatter.dateFormat = localizedFormat
        let date = Date(timeIntervalSince1970: TimeInterval(doubleValue / 1000))
        let dateString = dateFormatter.string(from: date)
        
        return dateString == "" ? "---" : dateString
    }
    
    func stringByStrippingHTML() -> String{
      return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func stringByReplacingFirstOccurrenceOfString(target: String, withString replaceString: String) -> String {
        if let range = self.range(of: target) {
            return self.replacingCharacters(in: range, with: replaceString)
        }
        return self
    }

    var localizedString: String {
        NSLocalizedString(self, comment: "")
    }
    
     
    var decodingUnicodeCharacters: String { applyingTransform(.init("Hex-Any"), reverse: false) ?? "" }
     
    /**
     Return an string in between two given strings, if it exists
     */
    func slice(from: String, to: String) -> String? {
        return (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
    func getFormattedDate() -> String {
        var resultString = ""
        
        let dateFormatted = DateFormatter()
        dateFormatted.dateFormat = "yyyyMMdd"
        
        guard  let date: Date = dateFormatted.date(from: self) else {
            return resultString
        }
        
        dateFormatted.dateFormat = "dd MMM yyyy"
        
        let locale = Locale(identifier: LanguageManagerSwift.getCurrentLanguageCode())
        dateFormatted.locale = locale
        
        let dateComponets: DateComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date)

        if LanguageManagerSwift.getCurrentLanguageCode() == "zh-Hans" {
            resultString = "\(dateComponets.day ?? 01)日 \(dateComponets.month ?? 01)月 \(dateComponets.year ?? 01)年 上午\(dateComponets.hour ?? 01):\(dateComponets.minute ?? 01)"
        } else {
            resultString = dateFormatted.string(from: date)
        }
        
        return resultString
    }
    
}

