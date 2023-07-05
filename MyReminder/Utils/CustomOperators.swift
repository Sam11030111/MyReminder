//
//  CustomOperators.swift
//  MyReminder
//
//  Created by 李竑陞 on 2023/7/3.
//

import Foundation
import SwiftUI

public func ??<T>(lhs: Binding<Optional<T>>, rhs: T) -> Binding<T> {
    Binding (
        get: { lhs.wrappedValue ?? rhs },
        set: { lhs.wrappedValue = $0 }
    )    
}
