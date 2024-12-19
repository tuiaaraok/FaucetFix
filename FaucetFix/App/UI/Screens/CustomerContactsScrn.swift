import SwiftUI

@available(iOS 16.0, *)
struct CustomerContactsScrn: View {
    @Binding var navPath: [Scrns]
    
    @State private var contacts: [Contact] = [
        Contact(name: "Name Of contact", phoneNumber: "+919876543210", email: "email@example.com", address: "st. address", description: "Some description of contact"),
        Contact(name: "Name Of contact", phoneNumber: "+919876543210", email: "email@example.com", address: "st. address", description: "Some description of contact"),
        Contact(name: "Name Of contact", phoneNumber: "+919876543210", email: "email@example.com", address: "st. address", description: "Some description of contact"),
    ]
    
    private let storage = Storage.shared
    
    var body: some View {
        VStack(spacing: 0) {
            
            BackBtn(navPath: $navPath)
                .offset(x: 15,y: 53)
            AddActnBtn(txt: "Add a contact", actn: toContactAddingScrn)
            
            List {
                ForEach(contacts) { contact in
                    ContactView(contact: contact)
                        .listRowBackground(Color.clear)
                        .padding(.bottom, 20)
                }
                .onDelete { indexSet in
                    contacts.remove(atOffsets: indexSet)
                    storage.saveContacts(contacts)
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
            contacts = storage.getContacts()
        }
        
    }
    private func toContactAddingScrn() {
        navPath.append(Scrns.contactAdding)
    }
}

@available(iOS 16.0, *)
private struct ContactView: View {
    
    let contact: Contact
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color.black, radius: 0, x: 4, y: 4)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Client: \(contact.name)")
                    Text("Contact: \(contact.phoneNumber)")
                    Text("Email: \(contact.email)")
                    Text("Address: \(contact.address)")
                    Text("Description: \(contact.description)")
                }
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                .customFont(.infTxt)
                .foregroundStyle(Color.black)
                Spacer()
            }
            
            
        }.frame(maxWidth: .infinity, minHeight: 156)
    }
}


