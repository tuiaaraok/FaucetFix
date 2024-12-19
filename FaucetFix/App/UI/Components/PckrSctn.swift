import SwiftUI

struct PckrSctn: View {
    @Binding var showPicker: Bool
    @Binding var date: Date
    var pickerType: ComponentType
    
    enum ComponentType {
        case date
        case hourAndMinute
    }
    
    var body: some View {
        Group {
            if showPicker {
                if pickerType == .date {
                    DatePicker("", selection: $date, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .background(Color.mainAdd)
                        .cornerRadius(10)
                        .transition(.opacity)
                        .padding(EdgeInsets(top: 33, leading: 33, bottom: 0, trailing: 33))
                        .onChange(of: date) { _ in
                            withAnimation {
                                showPicker = false
                            }
                        }
                } else {
                    DatePicker("", selection: $date, displayedComponents: .hourAndMinute)
                        .datePickerStyle(WheelDatePickerStyle())
                        .padding()
                        .background(Color.mainAdd)
                        .cornerRadius(10)
                        .transition(.opacity)
                        .padding(EdgeInsets(top: 33, leading: 33, bottom: 0, trailing: 33))
                        .onChange(of: date) { _ in
                            withAnimation {
                                showPicker = false
                            }
                        }
                }
            }
        }
    }
}

struct DtPckrBtn: View {
    let txt: String
    @Binding var dt: Date
    @Binding var showDatePicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(txt)
                .customFont(.infTxt)
                .foregroundColor(Color.black)
            
            Button(action: {
                withAnimation { showDatePicker.toggle() }
            }) {
                HStack {
                    Text(formattedDate(dt, frmt: "dd/MM/yyyy"))
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundColor(Color.black)
                .customFont(.infTxt)
                .padding(12)
                .frame(maxHeight: 45)
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                )
            }
        }.padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
    }
}

struct TmPckrBtn: View {
    let txt: String
    @Binding var tm: Date
    @Binding var showTimePicker: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(txt)
                .customFont(.infTxt)
                .foregroundColor(Color.black)
            
            Button(action: {
                withAnimation { showTimePicker.toggle() }
            }) {
                HStack {
                    Text(formattedDate(tm, frmt: "HH:mm"))
                        .foregroundStyle(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .foregroundColor(Color.black)
                .customFont(.infTxt)
                .padding(12)
                .frame(maxHeight: 45)
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .stroke(Color.black, lineWidth: 2)
                )
            }
        }.padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
    }
}
