//
//  Constant.swift
//  CodingChallenge
//
//  Created by Veena Chandran on 13/04/24.
//

import Foundation

class Constant {
    public static var shared: Constant = Constant()
    
    public var productURLString: String {
        get {
            return "https://dummyjson.com/products"
        }
    }
}
