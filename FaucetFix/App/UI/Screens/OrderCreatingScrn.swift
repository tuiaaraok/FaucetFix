import SwiftUI

struct OrderCreatingScrn: View {
    @Binding var navPath: [Scrns]
    
    @State var clientName: String = ""
    @State var date: Date = Date()
    @State var time: Date = Date()
    @State var address: String = ""
    @State var phoneNumber: String = ""
    @State var description: String = ""
    
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    
    private let storage = Storage.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                MainTxtFld(ttl: "Client's name", txt: $clientName)
                    .padding(.top, 30)
                MainTxtFld(ttl: "Phone number", txt: $phoneNumber)
                
                DtPckrBtn(txt: "Order date", dt: $date, showDatePicker: $showDatePicker)
                
                PckrSctn(
                    showPicker: $showDatePicker,
                    date: $date,
                    pickerType: .date
                )
                
                TmPckrBtn(txt: "Order time", tm: $time, showTimePicker: $showTimePicker)
                
                PckrSctn(
                    showPicker: $showTimePicker,
                    date: $time,
                    pickerType: .hourAndMinute
                )
                
                MainTxtFld(ttl: "Address", txt: $address)
                MainTxtFld(ttl: "Description", txt: $description, axis: .vertical, maxHeigth: 150)
                
                ActnBtns(cancelButtonAction: cancel, saveButtonAction: save)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)

    }
    private func save() {
        let order = Order(
            clientName: clientName,
            date: date,
            time: time,
            address: address,
            phoneNumber: phoneNumber,
            description: description)
        storage.saveOrder(order)
        navPath.removeLast()
    }
    
    private func cancel() {
        navPath.removeLast()
    }
}

#Preview {
    @Previewable @State var navPath: [Scrns] = []
    OrderCreatingScrn(navPath: $navPath)
}



