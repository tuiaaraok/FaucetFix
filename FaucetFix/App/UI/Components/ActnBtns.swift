import SwiftUI

struct ActnBtns: View {
    
    let cancelButtonAction: () -> Void
    let saveButtonAction: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: cancelButtonAction) {
                ZStack {
                    Rectangle()
                        .fill(Color.white)
                        .shadow(color: Color.black, radius: 0, x: 4, y: 4)
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                    Text("Cancel")
                        .padding(14)
                        .customFont(.actnBtnsTxt)
                        .foregroundStyle(Color.black)
                }
            }.frame(maxWidth: 140, maxHeight: 52)
            Button(action: saveButtonAction) {
                ZStack {
                    Rectangle()
                        .fill(Color.mainAdd)
                        .shadow(color: Color.black, radius: 0, x: 4, y: 4)
                        .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                    Text("Save")
                        .padding(14)
                        .customFont(.actnBtnsTxt)
                        .foregroundStyle(Color.white)
                }.frame(maxWidth: 140, maxHeight: 52)
            }
        }
        .navigationBarBackButtonHidden(true)
        .padding(.top, 60)
    }
}

#Preview {
    ActnBtns(cancelButtonAction: {}, saveButtonAction: {})
}
