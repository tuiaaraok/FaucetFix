import SwiftUI

struct BackBtn: View {
    @Binding var navPath: [Scrns]
    
    var body: some View {
        Button(action: {
            if !navPath.isEmpty {
                navPath.removeLast(navPath.count)
            }
        }) {
            HStack(spacing: 0) {
                Image(systemName: "arrowtriangle.backward.fill")
                    .resizable()
                    .foregroundStyle(Color.mainAdd)
                    .frame(width: 25, height: 25)
                Spacer()
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    @Previewable @State var navPath: [Scrns] = []
    BackBtn(navPath: $navPath)
}
