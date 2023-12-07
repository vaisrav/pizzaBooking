//
//  pizzaOrder.swift
//  vaisrav_pizza
//
//  Created by Graphic on 2023-06-05.
//

import Foundation

class PizzaOrder: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var pizzaType: String = "Non-veg"
    @Published var pizzaSize: String = "Medium"
    @Published var quantity: Int = 1
    @Published var couponCode: String = ""
    @Published var isCouponValid = false
    
    var subtotal: Double {
        var price : Double
        if isCouponValid {
                    price = 5.0
                } else {
                    price = getPriceForPizzaSize(pizzaSize, pizzaType)
                }
        return Double(quantity) * price
    }
    
    var taxAmount: Double {
        return subtotal * 0.13
    }
    
    var finalCost: Double {
        return subtotal + taxAmount
    }
    
    func getPriceForPizzaSize(_ size: String, _ type: String) -> Double {
        switch (size, type) {
        case ("Small", "Veg"):
            return 5.99
        case ("Small", "Non-veg"):
            return 6.99
        case ("Medium", "Veg"):
            return 7.99
        case ("Medium", "Non-veg"):
            return 8.99
        case ("Large", "Veg"):
            return 10.99
        case ("Large", "Non-veg"):
            return 12.99
        default:
            return 0.0
        }
    }
}
