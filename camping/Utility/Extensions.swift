//
//  Extensions.swift
//  camping
//
//  Created by Eric Askari on 11.4.2023.
//

import Foundation
import SwiftUI

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
    }
}

extension Date {
   static var tomorrow:  Date { return Date().dayAfter }
   static var today: Date {return Date()}
   var dayAfter: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
   }
}


// Round double to zero decimal
extension Double {
    func roundedDouble() -> String {
        return String(format: "%.0f", self)
    }
}
