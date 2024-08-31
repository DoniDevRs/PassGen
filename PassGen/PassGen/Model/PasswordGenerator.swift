//
//  PasswordGenerator.swift
//  PassGen
//
//  Created by Doni Silva on 28/08/24.
//

import Foundation

public struct Password {
    var numberOfPasswords: Int
    var numberOfCharacters: Int
    var useLetters: Bool
    var useNumbers: Bool
    var useCapitalLetters: Bool
    var useSpecialCharacters: Bool
}

class PasswordGenerator {
    
    var passwordsList: [String] = []
    
    private let letters = "abcdefghijklmnopqrstuvxz"
    private let numbers = "1234567890"
    private let specialCharacters = "!@#$%ˆ&*()"
    
    func generate(password: Password) -> [String] {
        passwordsList.removeAll()
        
        var universe: String = ""
        
        if password.useLetters {
            universe += letters
        }
        
        if password.useCapitalLetters {
            universe += letters.uppercased()
        }
        
        if password.useNumbers {
            universe += numbers
        }
        
        if password.useSpecialCharacters{
            universe += specialCharacters
        }
        
        let universeArray = Array(universe)
        
        while passwordsList.count < password.numberOfPasswords {
            var newPassword: String = ""
            for _ in 1...password.numberOfCharacters{
                let index = Int(arc4random_uniform(UInt32(universeArray.count)))
                newPassword += String(universeArray[index])
            }
            passwordsList.append(newPassword)
        }
        return passwordsList
    }
}

