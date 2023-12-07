//
//  recieptView.swift
//  vaisrav_pizza
//
//  Created by Graphic on 2023-06-05.
//

import Foundation
import SwiftUI

struct ReceiptView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var order: PizzaOrder
    
    var body: some View {
        VStack {
            Text("Receipt")
                .font(.title)
                .bold()
                .padding()
            
            Group {
                Text("Phone: \(order.phoneNumber)")
                Text("Size: \(order.pizzaSize)")
                Text("Type: \(order.pizzaType)")
                Text("Quantity: \(order.quantity)")
                Text("Coupon: \(order.couponCode)")
                Text("Subtotal: $\(order.subtotal, specifier: "%.2f")")
                Text("Tax: $\(order.taxAmount, specifier: "%.2f")")
                    .fontWeight(.semibold)
                Text("Total: $\(order.finalCost, specifier: "%.2f")")
                    .fontWeight(.semibold)
            }
            .padding()
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Back to Order")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
