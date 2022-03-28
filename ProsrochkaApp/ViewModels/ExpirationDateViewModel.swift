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
    
    var changingDate: ((String?) -> Void)?
    var date: String? {
        didSet {
            
        }
    }
    var finalDate: Date?
    var createdDate: Date?
    var data: DateChange?
    
    
    func formattedFinalDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: finalDate ?? Date())
    }
    
    func calculateExpDate(date: String?) {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        let dt = dateFormatter.date(from: date ?? "")
        changingDate = { value in
            self.createdDate = dt
            self.finalDate = calendar.date(byAdding: self.getDate(dateEnum: self.data ?? DateChange.day), value: Int(value ?? "")!, to: dt ?? Date())
        }
    }
    
    func getDate(dateEnum: DateChange) -> Calendar.Component {
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
