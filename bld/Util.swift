//
//  Util.swift
//  bld
//
//  Created by John Sarracino on 12/6/16.
//  Copyright © 2016 Eric Fakhourian. All rights reserved.
//

import Foundation
//
//func sumList<T>(xs : [T]) -> Int {
//    return xs.reduce(0) { $0 + $1}
//}

func sumList(xs: [Int]) -> Int {
    return xs.reduce(0, +)
}

func flattenDict<K, V>(dict: [K: [V]]) -> [V] {
    var ret = [V]()
    for (_, vs) in dict {
        ret += vs
    }
    return ret
}



func diff (xs: [Ingredient], ys: [Ingredient]) -> [Ingredient] {
    func inY(t: Ingredient) -> Bool {
         do {
            return try ys.contains(t)
        } catch _ {
            print("diff threw an exception")
            return false
        }

    }
    return xs.filter{return inY(t: $0)}
    
}
