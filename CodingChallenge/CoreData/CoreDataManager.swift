//
//  CoreDataManager.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 12/04/24.
//

import CoreData
import Foundation

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CodingChallenge")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
        
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getCartProducts() -> [Product] {
        var products = [Product]()
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        do {
            products = try context.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        return products
    }
    
    func addToCart(selectedProduct: ProductDetailsViewModel) {
        let product = Product(context: context)
        product.id = selectedProduct.id
        product.title = selectedProduct.title
        product.price = selectedProduct.price
        product.rating = selectedProduct.rating
        product.details = selectedProduct.description
        product.thumbnail = selectedProduct.thumbnail?.absoluteString
        product.imageString = selectedProduct.productImage?.absoluteString
        saveContext()
    }
}
