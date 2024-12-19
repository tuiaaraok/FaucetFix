import SwiftUI

@available(iOS 16.0, *)
struct OrderManagementScrn: View {
    @Binding var navPath: [Scrns]
    
    @State private var orders: [Order] = [
        Order(clientName: "Name", date: Date(), time: Date(), address: "Address", phoneNumber: "+9999999999", description: "Description"),
        Order(clientName: "Name", date: Date(), time: Date(), address: "Address", phoneNumber: "+9999999999", description: "Description")
    ]
    
    private let storage = Storage.shared
    
    var body: some View {
        VStack(spacing: 0) {
            
            BackBtn(navPath: $navPath)
                .offset(x: 15,y: 53)
            AddActnBtn(txt: "Create a new order", actn: toOrderCreatingScrn)
            
            List {
                ForEach(orders) { order in
                    OrderView(order: order)
                        .listRowBackground(Color.clear)
                        .padding(.bottom, 20)
                }
                .onDelete { indexSet in
                    orders.remove(atOffsets: indexSet)
                    storage.saveOrders(orders)
                }
                
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(.hidden)
            .padding(EdgeInsets(top: 32, leading: 12, bottom: 0, trailing: 12))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .onAppear {
            orders = storage.getOrders()
        }
        
    }
    private func toOrderCreatingScrn() {
        navPath.append(Scrns.orderCreating)
    }
}

@available(iOS 16.0, *)
private struct OrderView: View {
    
    let order: Order
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color.black, radius: 0, x: 4, y: 4)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Client: \(order.clientName)")
                    HStack(spacing: 18) {
                        Text("Date: \(formattedDate(order.date, frmt: "dd/MM/yyyy"))")
                        Text("Time: \(formattedDate(order.date, frmt: "HH:mm"))")
                    }
                    Text("Address: \(order.address)")
                    Text("Contact: \(order.phoneNumber)")
                    Text("Description: \(order.description)")
                }
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                .customFont(.infTxt)
                .foregroundStyle(Color.black)
                Spacer()
            }
            
            
        }.frame(maxWidth: .infinity, minHeight: 156)
    }
}

