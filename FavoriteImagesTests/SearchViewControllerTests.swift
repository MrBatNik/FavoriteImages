//
//  SearchViewControllerTests.swift
//  SearchViewControllerTests
//
//  Created by Nikita Batrakov on 09.05.2023.
//

import XCTest
@testable import FavoriteImages

final class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!
    var presenterMock: SearchViewPresentationLogicMock!
    
    override func setUp() {
        super.setUp()
        presenterMock = SearchViewPresentationLogicMock()
        sut = SearchViewController(presenter: presenterMock)
    }
    
    override func tearDown() {
        presenterMock = nil
        sut = nil
        super.tearDown()
    }
    
    class SearchViewPresentationLogicMock: SearchViewPresentationLogic {
        var viewController: SearchViewLogic?
        var expectation: XCTestExpectation?
        var didCallOnInitialSetup: Bool = false
        
        func initialSetup() {
            didCallOnInitialSetup = true
        }
        
        func onQueryButtonTap(_ image: String?) {}
        
        func onFavoriteButtonTap(_ text: String?) {}
        
    }
    
    func testViewDidLoadCallsPresenterInitialSetup() {
        // Given
        let expectation = self.expectation(description: "Expected presenter.initialSetup() to be called")
        presenterMock.expectation = expectation
        
        // When
        sut.viewDidLoad()
        presenterMock.expectation?.fulfill()
        
        // Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(presenterMock.didCallOnInitialSetup)
    }
    
}
