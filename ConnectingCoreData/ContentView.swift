//
//  ContentView.swift
//  ConnectingCoreData
//
//  Created by Walter Bernal Montero on 06/10/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Dish.name, ascending: true)], animation: .default)
    private var dishes: FetchedResults<Dish>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Dessert.name, ascending: true)],
        animation: .default)
    private var desserts: FetchedResults<Dessert>
        

    var body: some View {
        NavigationView {
            VStack {
                Text("Dishes")
                    .font(.title)
                List {
                    ForEach(dishes) { dish in
                        VStack(alignment: .leading){
                            Text (dish.name!)
                            HStack (spacing: 40){
                                Text (dish.size!)
                                Spacer ()
                                Text("$S\(dish.price, specifier: "%.2f")")
                            }
                            .foregroundColor(.gray)
                            .font(.callout)
                        }
                    }
                }
                Divider()
                Text("Desserts")
                    .font(.title)
                List {
                    ForEach(desserts) { dessert in
                        VStack(alignment: .leading){
                            Text(dessert.name!)
                            HStack (spacing: 40) {
                                Text(dessert.size!)
                                Spacer()
                                Text("$\(dessert.price, specifier: "%.2f")")
                            }
                            .foregroundColor(.gray)
                            .font(.callout)
                        }
                    }
                }
                Divider()
                HStack(spacing: 50) {
                    Button(action: {
                        createDishes()
                    }, label: {
                        Text("Add dishes")
                    })
                    Button(action: {
                        createDesserts()
                    }, label: {
                        Text("Add desserts")
                    })
                }
            }
        }
    }
    
    func createDishes() {
        let hamburger = Dish(context: viewContext)
        hamburger.name = "Kingu"
        hamburger.price = 5.99
        hamburger.size = "Large"
        let salad = Dish(context: viewContext)
        salad.name = "Green"
        salad.price = 3.99
        salad.size = "Medium"
        let doubleCheeseBurger = Dish(context: viewContext)
        doubleCheeseBurger.name = "Cheezy"
        doubleCheeseBurger.price = 6.49
        doubleCheeseBurger.size = "Extra Large"
        saveDatanase()
    }
    func createDesserts() {
        let cheeseCake = Dessert(context: viewContext)
        cheeseCake.name = "Cheese Cake"
        cheeseCake.price = 2.99
        cheeseCake.size = "Small"
        let iceCream = Dessert(context: viewContext)
        iceCream.name = "Vanilla Ice Cream"
        iceCream.price = 2.49
        iceCream.size = "Small"
        saveDatanase()
    }
    func saveDatanase() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch (let error ) {
            print(error.localizedDescription)
        }
    }
}

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
//
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
