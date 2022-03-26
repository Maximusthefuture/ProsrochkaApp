//
//  ExpirationDateViewModel.swift
//  ProsrochkaApp
//
//  Created by Maximus on 26.03.2022.
//

import Foundation


enum DateChange {
    case day
    case month
    case year
}


class ExpirationDateViewModel {
    
    var createDate: ((String?) -> Void)?
    var changingDate: ((String?) -> Void)?
    var dateChangeEnum: ((DateChange) -> Void)?
    
    func calculateExpDate(date: String) {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        
        
        let dt = dateFormatter.date(from: date)
        changingDate = { value in
            let finalDate = calendar.date(byAdding: self.getDate(dateEnum: DateChange.day), value: Int(value ?? "")!, to: dt!)
            print("final date", finalDate)
        }
    }
    
    func getDate(dateEnum: DateChange) -> Calendar.Component{
        var componentsEnum = Calendar.Component.day
        switch dateEnum {
        case .day:
            componentsEnum = .day
        case .month:
            componentsEnum = .month
        case .year:
            componentsEnum = .year
        }
        return componentsEnum
        
    }
}
