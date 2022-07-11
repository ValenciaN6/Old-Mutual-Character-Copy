//
//  ISourceProtocol.swift
//  CharacterCopy
//
//  Created by Ntshembo Valentia Magagane on 2022/07/06.
//

import Foundation

protocol ISourceProtocol {
    func readChar() -> Character
    func readChars(count: Int) -> [Character]
}
