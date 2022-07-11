//
//  Copier.swift
//  CharacterCopy
//
//  Created by Ntshembo Valentia Magagane on 2022/07/06.
//

import Foundation

class Copier {
    var source:ISourceProtocol
    var destination:IDestinationProtocol
    let newLine: Character = "\n"
    
    init(source: ISourceProtocol, destination: IDestinationProtocol) {
        self.source = source
        self.destination = destination
    }
    
    func copy() {
        var readChar = source.readChar()
        
        while readChar != newLine {
            destination.writeChar(char: readChar)
            readChar = source.readChar()
        }
    }
    
    func copy(numChars: Int) {
        var readChars:[Character]
        
        repeat {
            readChars = source.readChars(count: numChars)
            
            if readChars.isEmpty {
                break
            }
            
            if let newLinePosition = readChars.firstIndex(of: newLine) {
                
                let removeNewLine = readChars[0..<newLinePosition]
                
                if(removeNewLine.isEmpty) {
                    break
                    
                } else {
                    
                    destination.writeChars(char: Array(readChars[0..<newLinePosition]))
                }
            } else {
                
                destination.writeChars(char: readChars)
            }
            
        }while(!readChars.contains(newLine));
    }
    
}
