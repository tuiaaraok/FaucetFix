import SwiftUI

struct AddActnBtn: View {
    let txt: String
    let actn: () -> Void
    
    var body: some View {
        Button(action: actn) {
            ZStack {
                Rectangle()
                    .fill(Color.mainAdd)
                    .shadow(color: Color.black, radius: 0, x: 4, y: 4)
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
                Text(txt)
                    .padding(14)
                    .customFont(.addActnBtnTxt)
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 52)
        }
        .padding(EdgeInsets(top: 15, leading: 57, bottom: 0, trailing: 57))
    }
}

#Preview {
    AddActnBtn(txt: "Some Text", actn: {})
}

