//
//  AgeServiceTests.swift
//  AgeCalculatorTests
//
//  Created by Hakan Or on 8.03.2024.
//

import XCTest
@testable import AgeCalculator

final class AgeServiceTests: XCTestCase {
    
    private var sut: AgeService!
    
    override func setUpWithError() throws {
        sut = AgeService.shared
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func test_age_service_daysUntilNextBirthday_should_return() {
        
        // Given
        let birthDateService = BirthDateService.shared
        
        var dateComponents = DateComponents()
        dateComponents.year = 2001
        dateComponents.month = 1
        dateComponents.day = 1
        let selectedBirthDate = Calendar.current.date(from: dateComponents)
        let selectedBirthDate = Date(from: selectedBirthDate)
        
        // Set the selected birth date for testing
        birthDateService.selectedBirthDate = BirthDate(birthDate: selectedBirthDate)
        
        // When
        // Calculate the days until the next birthday
        let daysUntilNextBirthday = sut.daysUntilNextBirthday(birthday: selectedBirthDate)
        
        // Then
        // Validate the result
        XCTAssertEqual(daysUntilNextBirthday, expectedDaysUntilNextBirthday)
    }
}
