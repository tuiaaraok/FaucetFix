import SwiftUI

@available(iOS 16.0, *)
struct ContactAddingScrn: View {
    @Binding var navPath: [Scrns]
    
    @State var name: String = ""
    @State var phoneNumber: String = ""
    @State var email: String = ""
    @State var address: String = ""
    @State var description: String = ""
    
    @State private var showDatePicker = false
    @State private var showTimePicker = false
    
    private let storage = Storage.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                MainTxtFld(ttl: "Client's name", txt: $name)
                    .padding(.top, 30)
                MainTxtFld(ttl: "Phone number", txt: $phoneNumber)
                MainTxtFld(ttl: "Email", txt: $email)
                MainTxtFld(ttl: "Address", txt: $address)
                MainTxtFld(ttl: "Description", txt: $description, axis: .vertical, maxHeigth: 150)
                
                ActnBtns(cancelButtonAction: cancel, saveButtonAction: save)
            }

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)

    }
    private func save() {
        let contact = Contact(
            name: name,
            phoneNumber: phoneNumber,
            email: email,
            address: address,
            description: description
        )
        storage.saveContact(contact)
        navPath.removeLast()
    }
    
    private func cancel() {
        navPath.removeLast()
    }
}





