//
//  String+Ext.swift
//  PassGen
//
//  Created by Doni Silva on 29/08/24.
//

import Foundation

extension String {
    public var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
