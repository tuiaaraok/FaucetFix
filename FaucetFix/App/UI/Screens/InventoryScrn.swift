import SwiftUI

struct InventoryScrn: View {
    @Binding var navPath: [Scrns]
    
    @State private var stocks: [Stock] = []
    
    private let storage = Storage.shared
    
    var body: some View {
        VStack(spacing: 0) {
            
            BackBtn(navPath: $navPath)
                .offset(x: 15,y: 53)
            AddActnBtn(txt: "Add stock", actn: toAStockAddingScrn)
            
            StockView(
                category: "Tools",
                stocks: $stocks.filterBinding { $0.category == "Tools" }
            )
            
            StockView(
                category: "Materials",
                stocks: $stocks.filterBinding { $0.category == "Materials" }
            )
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .onAppear {
            stocks = storage.getStocks()
        }
        
    }
    private func toAStockAddingScrn() {
        navPath.append(Scrns.stockAdding)
    }
}

extension Binding where Value: MutableCollection, Value.Element: Identifiable {
    func filterBinding(_ isIncluded: @escaping (Value.Element) -> Bool) -> Binding<[Value.Element]> {
        Binding<[Value.Element]>(
            get: {
                self.wrappedValue.filter(isIncluded)
            },
            set: { newValue in
                for newElement in newValue {
                    if let index = self.wrappedValue.firstIndex(where: { $0.id == newElement.id }) {
                        self.wrappedValue[index] = newElement
                    }
                }
            }
        )
    }
}

private struct StockView: View {
    let category: String
    @Binding var stocks: [Stock]
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(Color.white)
                .shadow(color: Color.black, radius: 0, x: 4, y: 4)
                .overlay(Rectangle().stroke(Color.black, lineWidth: 2))
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 20) {
                    Text(category)
                        .customFont(.toolsTtlTxt)
                        .foregroundStyle(Color.black)
                    List {
                        ForEach($stocks) { $stock in
                            StockPodView(stock: $stock)
                                .listRowBackground(Color.clear)
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                }
                .padding(EdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5))
                Spacer()
            }
            
            
        }
        .frame(maxWidth: .infinity)
        .padding(32)
    }
}

struct StockPodView: View {
    
    @Binding var stock: Stock
    
    private let storage = Storage.shared
    
    var body: some View {
        
        HStack(spacing: 14) {
            Text(stock.name)
                
            Spacer()
            HStack(spacing: 14) {
                Button(action: minusButtonAction) {
                    Image(systemName: "minus.circle")
                        .frame(maxWidth: 25, maxHeight: 25)
                }
                    .buttonStyle(.plain)
                Text("\(stock.quantity)")
                Button(action: plusButtonAction) {
                    Image(systemName: "plus.circle")
                        .frame(maxWidth: 25, maxHeight: 25)
                }
                .buttonStyle(.plain)
            }
        }
        .customFont(.infTxt)
        .foregroundStyle(Color.black)
    }
    
    private func minusButtonAction() {
        if stock.quantity > 0 {
            stock.quantity -= 1
            storage.updateStockCountById(id: stock.id, quantity: stock.quantity)
        }
    }
    
    private func plusButtonAction() {
        stock.quantity += 1
        storage.updateStockCountById(id: stock.id, quantity: stock.quantity)
    }
}

#Preview {
    @Previewable @State var navPath: [Scrns] = []
    OrderManagementScrn(navPath: $navPath)
}



