import SwiftUI

struct EntryAddingScrn: View {
    @Binding var navPath: [Scrns]
    
    @State var date: Date = Date()
    @State var clientName: String = ""
    @State var order: String = ""
    @State var workingTime: String = ""
    @State var materials: [ObjectWithNameOnly] = []
    @State var description: String = ""
    @State var workImage: UIImageData? = nil
    
    @State var clients: [Contact] = []
    
    @State private var showDatePicker = false
    @State private var isMenuVisible = false
    
    private let storage = Storage.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                DtPckrBtn(txt: "Date of work", dt: $date, showDatePicker: $showDatePicker)
                    .padding(.top, 30)
                
                PckrSctn(
                    showPicker: $showDatePicker,
                    date: $date,
                    pickerType: .date
                )
                
                ClientSelectionView(clientName: $clientName, isMenuVisible: $isMenuVisible)
                
                if isMenuVisible {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(clients) { client in
                                Button(action: {
                                    clientName = client.name
                                    isMenuVisible = false
                                }) {
                                    Text(client.name)
                                        .customFont(.infTxt)
                                        .foregroundStyle(Color.black)
                                        .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                                    
                                }
                                
                                Divider()
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .background(Color.white)
                    .padding(EdgeInsets(top: 12, leading: 32, bottom: 0, trailing: 32))
                    .frame(maxHeight: 200)
                }
              
                MainTxtFld(ttl: "Order", txt: $order)
                MainTxtFld(ttl: "Working hours", txt: $workingTime)
                
                Text("Materials")
                    .customFont(.infTxt)
                    .foregroundColor(Color.black)
                
                Button(action: addNewMaterial) {
                    Image(systemName: "plus.circle")
                        .foregroundStyle(Color.black)
                        .frame(width: 34, height: 34)
                }
                
                VStack(spacing: 10) {
                    ForEach($materials) { $material in
                        MaterialView(material: $material)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                MainTxtFld(ttl: "Description", txt: $description, axis: .vertical, maxHeigth: 150)
                
                ImagePickerView(imageData: $workImage)
                
                ActnBtns(cancelButtonAction: cancel, saveButtonAction: save)
            }
        }
        .onAppear {
            clients = storage.getContacts()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        
    }
    private func save() {
        let workRecord = WorkRecord(
            date: date,
            clientName: clientName,
            order: order,
            workingTime: workingTime,
            materials: materials,
            description: description,
            workImage: workImage
        )
        storage.saveWorkRecord(workRecord)
        navPath.removeLast()
    }
    
    private func cancel() {
        navPath.removeLast()
    }
    private func addNewMaterial() {
        let newMaterial = ObjectWithNameOnly(name: "")
        materials.append(newMaterial)
    }
}

private struct MaterialView: View {
     
    @Binding var material: ObjectWithNameOnly
    
    var body: some View {
        MainTxtFld(ttl: "Material", txt: $material.name)
    }
}

private struct ClientSelectionView: View {
    @Binding var clientName: String
    @Binding var isMenuVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text("Select a client")
                .customFont(.infTxt)
                .foregroundStyle(Color.black)
            
            Button(action: {
                withAnimation {
                    isMenuVisible.toggle()
                }
            }) {
                HStack(spacing: 0) {
                    Text(clientName)
                        .customFont(.infTxt)
                        .foregroundStyle(Color.black)
                        .padding(12)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(Color.black)
                        .padding(.trailing, 6)
                }
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                )
                .frame(maxHeight: 45)
            }
        }.padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
    }
}



#Preview {
    @Previewable @State var navPath: [Scrns] = []
    EntryAddingScrn(navPath: $navPath)
}






