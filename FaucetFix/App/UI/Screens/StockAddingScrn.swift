import SwiftUI

struct StockAddingScrn: View {
    @Binding var navPath: [Scrns]
    
    @State private var category: String = "Tools"
    @State private var name: String = ""
    @State private var quantity: String = ""
    @State private var showError: Bool = false

    private let categoriesObjects: [ObjectWithNameOnly] = [ObjectWithNameOnly(name: "Tools"), ObjectWithNameOnly(name: "Materials")]
    @State private var isMenuVisible = false
    
    private let storage = Storage.shared
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                MainTxtFld(ttl: "Name", txt: $name)
                    .padding(.top, 30)
                MainTxtFld(ttl: "Quantity", txt: $quantity, keyboardType: .numberPad)
                
                if showError {
                    Text("Quantity must be a valid number")
                        .customFont(.infTxt)
                        .foregroundStyle(Color.red)
                }
                
                CategorySelectionView(category: $category, isMenuVisible: $isMenuVisible)
                if isMenuVisible {
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(categoriesObjects) { categoryObject in
                                Button(action: {
                                    category = categoryObject.name
                                    isMenuVisible = false
                                }) {
                                    Text(categoryObject.name)
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
                
                ActnBtns(cancelButtonAction: cancel, saveButtonAction: save)
                    .disabled(!isQuantityValid())
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    private func isQuantityValid() -> Bool {
        return Int(quantity) != nil
    }
    
    private func save() {
        if isQuantityValid() {
            let stock = Stock(category: category, name: name, quantity: Int(quantity) ?? 0)
            storage.saveStock(stock)
            navPath.removeLast()
        } else {
            showError = true
        }
    }
    
    private func cancel() {
        navPath.removeLast()
    }
}

private struct CategorySelectionView: View {
    @Binding var category: String
    @Binding var isMenuVisible: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            Text("Category")
                .customFont(.infTxt)
                .foregroundStyle(Color.black)
            
            Button(action: {
                withAnimation {
                    isMenuVisible.toggle()
                }
            }) {
                HStack(spacing: 0) {
                    Text(category)
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
    StockAddingScrn(navPath: $navPath)
}



