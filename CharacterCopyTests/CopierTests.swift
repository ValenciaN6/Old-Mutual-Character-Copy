//
//  CopierTests.swift
//  CharacterCopyTests
//
//  Created by Ntshembo Valentia Magagane on 2022/07/06.
//

import XCTest
import Mockingbird
@testable import CharacterCopy

class CopierTests: XCTestCase {
    var mockSource = mock(ISourceProtocol.self)
    var mockDestination = mock(IDestinationProtocol.self)
    var serviceUnderTest: Copier!

    override func setUp() {
        super.setUp()
        serviceUnderTest = Copier(source: mockSource, destination: mockDestination)
    }
    
    func testCopierCopiesCharacter() throws {
        given(mockSource.readChar())
            .willReturn("v")
            .willReturn("c")
            .willReturn("t")
            .willReturn("\n")
        
        serviceUnderTest.copy()
        
        verify(mockSource.readChar()).wasCalled(exactly(4))
        verify(mockDestination.writeChar(char: "v")).wasCalled()
        verify(mockDestination.writeChar(char: "c")).wasCalled()
        verify(mockDestination.writeChar(char: "t")).wasCalled()
        verify(mockDestination.writeChar(char: "\n")).wasNeverCalled()
    }
    
    func testCopierDoesntCopyCharacter() throws {
        given(mockSource.readChar()).willReturn("\n")
            .willReturn("t")
            .willReturn("c")

        serviceUnderTest.copy()

        verify(mockSource.readChar()).wasCalled()
        verify(mockDestination.writeChar(char: "\n")).wasNeverCalled()
        verify(mockDestination.writeChar(char: "t")).wasNeverCalled()
        verify(mockDestination.writeChar(char: "c")).wasNeverCalled()
    }
    
    func testCopyEncounterNewLineCharacterAndStopsCopying() throws {
        given(mockSource.readChar()).willReturn("r")
            .willReturn("\n")
            .willReturn("c")

        serviceUnderTest.copy()

        verify(mockSource.readChar()).wasCalled(exactly(2))
        verify(mockDestination.writeChar(char: "r")).wasCalled()
        verify(mockDestination.writeChar(char: "\n")).wasNeverCalled()
        verify(mockDestination.writeChar(char: "c")).wasNeverCalled()
    }

    func testCopyMultipleCharsCopiesCharacter() throws {
        given(mockSource.readChars(count: 4)).willReturn(["y","z","t","\n"])
        
        serviceUnderTest.copy(numChars: 4)
        
        verify(mockSource.readChars(count: 4)).wasCalled()
        verify(mockDestination.writeChars(char: ["y","z","t"])).wasCalled()
    }
    
    func testCopyCharacterStopCopyingAfterEncounteringNewLine() throws {
        given(mockSource.readChars(count: 3)).willReturn(["v","\n","t"])
        
        serviceUnderTest.copy(numChars: 3)
        
        verify(mockSource.readChars(count: 3)).wasCalled()
        verify(mockDestination.writeChars(char: ["v"])).wasCalled()
    }
    
    func testCopyCharacterExitsAfterNewLineEncounted() throws {
        given(mockSource.readChars(count: 0)).willReturn(["\n","v","t"])
        
        serviceUnderTest.copy(numChars: 0)
        
        verify(mockSource.readChars(count: 0)).wasCalled()
        verify(mockDestination.writeChars(char: ["\n","v","t"])).wasNeverCalled()
        
    }
    
    func testCopyCharacterDoesNotCopyEmptyArray() throws {
        given(mockSource.readChars(count: 0)).willReturn([])
        
        serviceUnderTest.copy(numChars: 0)
        
        verify(mockSource.readChars(count: 0)).wasCalled()
        verify(mockDestination.writeChars(char: [])).wasNeverCalled()
        
    }

}
