//
//  MockFileManager.swift
//  GithubManager
//
//  Created by Tree Bui Quang Tri on 20/5/25.
//


// Mock for FileManager operations
class MockFileManager {
    var mockFileExists = true
    var mockFileContent: String?
    var mockFileError: Error?
    
    var lastReadFileName: String?
    var lastWrittenFileName: String?
    var lastWrittenString: String = ""
    
    func fileExists(at path: String) -> Bool {
        return mockFileExists
    }
    
    func readString(from fileName: String) throws -> String? {
        lastReadFileName = fileName
        
        if let error = mockFileError {
            throw error
        }
        
        return mockFileContent
    }
    
    func writeString(_ string: String, to fileName: String) throws {
        lastWrittenFileName = fileName
        lastWrittenString = string
        
        if let error = mockFileError {
            throw error
        }
    }
}
