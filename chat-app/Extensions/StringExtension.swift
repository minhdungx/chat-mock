//
//  StringExtension.swift
//  Mock
//
//  Created by DungHM on 23/12/24.
//
import Foundation

extension String{
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
