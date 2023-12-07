//
//  ContentView.swift
//  vaisrav_pizza
//
//  Created by Graphic on 2023-06-05.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var order = PizzaOrder()
    @State private var showingReceipt = false
    @State private var showError = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Pizza Ordering App")
                    .font(.title)
                    .bold()
                    .padding()
                
                Image("pizza")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .padding()
                
                Form {
                    Section(header: Text("Pizza Details")) {
                        Picker("Pizza Type", selection: $order.pizzaType) {
                            Text("Vegetarian").tag("Veg")
                            Text("Non-vegetarian").tag("Non-veg")
                        }
                        
                        Picker("Pizza Size", selection: $order.pizzaSize) {
                            Text("Small").tag("Small")
                            Text("Medium").tag("Medium")
                            Text("Large").tag("Large")
                        }
                        
                        Stepper(value: $order.quantity, in: 1...5, label: {
                            Text("Quantity: \(order.quantity)")
                        })
                    }
                    
                    Section(header: Text("Customer Details")) {
                        TextField("Phone Number", text: $order.phoneNumber)
                            .keyboardType(.phonePad)
                        
                        TextField("Coupon Code", text: $order.couponCode)
                            .autocapitalization(.none)
                        
                        Spacer()
                        Button(action: {
                            
                            order.pizzaSize = "Large"
                            order.quantity = 2
                            order.pizzaType = "Non-veg"
                        }) {
                            Text("DAILY SPECIAL")
                                .foregroundColor(.blue)
                        }
                    
                    }
                }
                
                Button(action: {
                    
                    if validatePhone() {
                        if order.couponCode.isEmpty {
                            showingReceipt = true
                        }else  if validateCouponCode(order.couponCode) {
                            showingReceipt = true
                            order.isCouponValid = true
                        }else {
                            showError = true
                            order.isCouponValid = false
                        }
                    } else {
                        showError = true
                    }
                }) {
                    Text("PLACE ORDER")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showingReceipt) {
                    ReceiptView(order: order)
                }
                .alert(isPresented: $showError) {
                                    Alert(
                                        title: Text("Invalid entry"),
                                        message: Text("The entered coupon code or phone number is invalid."),
                                        dismissButton: .default(Text("OK"))
                                    )
                                }
                .padding()
            }
            .navigationTitle("Order Pizza")
            .navigationBarItems(trailing: Button(action: {
                            order.pizzaSize = "Medium"
                            order.quantity = 1
                            order.pizzaType = "Non-veg"
                            order.couponCode = ""
                            order.phoneNumber = ""
                        }) {
                            Text("RESET")
                                .foregroundColor(.red)
                        })
        }
    }
    
    func validateCouponCode(_ code: String) -> Bool {
        let lowercaseCode = code.lowercased()
        return lowercaseCode.hasPrefix("offer")
    }

    
    func validatePhone() -> Bool {
            guard !order.phoneNumber.isEmpty else {
                return false
            }
            return true
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
