//
//  JSONParserTests.swift
//  PhotoGalleryExerciseTests
//
//  Created by Nazario Mariano on 8/12/21.
//

import XCTest
@testable import PhotoGalleryExercise

class JSONParserTests: XCTestCase {
    func test_When_Parse_IsSet_With_TenPhotos_Should_Return_10Photos() {
        let parser = JSONParser()
        
        let expectation = self.expectation(description: "Expect correct count")
        
        var receivedPhotos: [Photo]?
        parser.parse(data: jsonData) { (photos: [Photo]?, error: Error?)  in
            receivedPhotos = photos
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(receivedPhotos!.count == 10)
    }
    
    func test_When_Parse_IsSet_With_OnePhoto_Should_Return_1Photo() {
        let parser = JSONParser()
        
        let expectation = self.expectation(description: "Expect correct count")
        
        var receivedPhotos: [Photo]?
        parser.parse(data: onePhotoData!) { (photos: [Photo]?, error: Error?)  in
            receivedPhotos = photos
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(receivedPhotos!.count == 1)
    }
    
    func test_When_Parse_IsSet_With_OnePhoto_Should_Return_1PhotoObject() {
        let parser = JSONParser()
        
        let expectation = self.expectation(description: "Expect correct count")
        
        var receivedPhotos: [Photo]?
        parser.parse(data: onePhotoData!) { (photos: [Photo]?, error: Error?)  in
            receivedPhotos = photos
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(receivedPhotos!.count == 1)

    }
    
    func test_When_Parse_IsSet_With_InvalidData_Should_Return_Error() {
        let parser = JSONParser()
        
        let expectation = self.expectation(description: "Expect correct count")
        
        var receivedError: Error?
        parser.parse(data: missingFieldData!) { (photos: [Photo]?, error: Error?)  in
            receivedError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // nil mean no error
        XCTAssertNotNil(receivedError)
    }
}
