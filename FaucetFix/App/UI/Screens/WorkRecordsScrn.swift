import SwiftUI

struct WorkRecordsScrn: View {
    @Binding var navPath: [Scrns]
    
    @State private var workRecords: [WorkRecord] = []
    
    private let storage = Storage.shared
    
    var body: some View {
        VStack(spacing: 0) {
            
            BackBtn(navPath: $navPath)
                .offset(x: 15,y: 53)
            AddActnBtn(txt: "Add entry", actn: toEntryAddingScrn)
            
            List {
                ForEach(workRecords) { workRecord in
                    WorkRecordView(workRecord: workRecord)
                        .listRowBackground(Color.clear)
                        .padding(.bottom, 20)
                }
                .onDelete { indexSet in
                    workRecords.remove(atOffsets: indexSet)
                    storage.saveWorkRecords(workRecords)
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
            workRecords = storage.getWorkRecords()
        }
        
    }
    private func toEntryAddingScrn() {
        navPath.append(Scrns.entryAdding)
    }
}

private struct WorkRecordView: View {
    
    let workRecord: WorkRecord
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color.black, radius: 0, x: 4, y: 4)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Date: \(formattedDate(workRecord.date, frmt: "dd/MM/yyyy"))")
                    Text("Client: \(workRecord.clientName)")
                    Text("Order: \(workRecord.order)")
                    Text("Working time: \(workRecord.workingTime)")
                    Text("Materials used: \(formattedMaterialsList(workRecord.materials))")
                    Text("Description: \(workRecord.description)")
                    ImageView(imageData: workRecord.workImage)
                }
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                .customFont(.infTxt)
                .foregroundStyle(Color.black)
                Spacer()
            }
            
            
        }.frame(maxWidth: .infinity, minHeight: 156)
    }
}

#Preview {
    @Previewable @State var navPath: [Scrns] = []
    WorkRecordsScrn(navPath: $navPath)
}



