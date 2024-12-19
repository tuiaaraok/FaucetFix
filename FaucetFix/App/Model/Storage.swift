import Foundation

class Storage: ObservableObject {
    
    static let shared = Storage()
    
    
    private let ordersKey = "orders"
    private let contactsKey = "contacts"
    private let workRecordsKey = "workRecords"
    private let stocksKey = "stocks"
    
    private init() {}
    
    func updateStockCountById(id: UUID, quantity: Int) {
        var stocks = getStocks()
        if let index = stocks.firstIndex(where: { $0.id == id }) {
            stocks[index].quantity = quantity
        }
        saveStocks(stocks)
    }

    func saveStock(_ stock: Stock) {
        var stocks = getStocks()
        stocks.append(stock)
        saveStocks(stocks)
    }

    func saveStocks(_ stocks: [Stock]) {
        if let data = try? JSONEncoder().encode(stocks) {
            UserDefaults.standard.set(data, forKey: stocksKey)
        }
    }

    func getStocks() -> [Stock] {
        guard let data = UserDefaults.standard.data(forKey: stocksKey),
              let stocks = try? JSONDecoder().decode([Stock].self, from: data) else {
            return []
        }
        return stocks
    }
    
    func saveWorkRecord(_ workRecord: WorkRecord) {
        var workRecords = getWorkRecords()
        workRecords.append(workRecord)
        saveWorkRecords(workRecords)
    }

    func saveWorkRecords(_ workRecords: [WorkRecord]) {
        if let data = try? JSONEncoder().encode(workRecords) {
            UserDefaults.standard.set(data, forKey: workRecordsKey)
        }
    }

    func getWorkRecords() -> [WorkRecord] {
        guard let data = UserDefaults.standard.data(forKey: workRecordsKey),
              let workRecords = try? JSONDecoder().decode([WorkRecord].self, from: data) else {
            return []
        }
        return workRecords
    }
    
    func saveContact(_ contact: Contact) {
        var contacts = getContacts()
        contacts.append(contact)
        saveContacts(contacts)
    }

    func saveContacts(_ contacts: [Contact]) {
        if let data = try? JSONEncoder().encode(contacts) {
            UserDefaults.standard.set(data, forKey: contactsKey)
        }
    }

    func getContacts() -> [Contact] {
        guard let data = UserDefaults.standard.data(forKey: contactsKey),
              let contacts = try? JSONDecoder().decode([Contact].self, from: data) else {
            return []
        }
        return contacts
    }
    
    func saveOrder(_ order: Order) {
        var orders = getOrders()
        orders.append(order)
        saveOrders(orders)
    }
    
    func saveOrders(_ orders: [Order]) {
        if let data = try? JSONEncoder().encode(orders) {
            UserDefaults.standard.set(data, forKey: ordersKey)
        }
    }
    
    func getOrders() -> [Order] {
        guard let data = UserDefaults.standard.data(forKey: ordersKey),
              let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            return []
        }
        return orders
    }
}


