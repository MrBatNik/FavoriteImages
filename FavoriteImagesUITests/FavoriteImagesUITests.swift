//
//  FavoriteImagesUITests.swift
//  FavoriteImagesUITests
//
//  Created by Nikita Batrakov on 09.05.2023.
//

import XCTest

class SearchViewControllerTests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testSearchViewController() throws {
        let searchView = app.searchView
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.1))
        
        let searchButton = searchView.searchButton
        let favoriteButton = searchView.favoriteButton
        let queryTextField = searchView.queryTextField
        let imageView = searchView.imageView
        
        XCTAssertTrue(queryTextField.exists)
        XCTAssertTrue(searchButton.exists)
        XCTAssertTrue(favoriteButton.exists)
        XCTAssertTrue(imageView.exists)
    }
    
}

private extension XCUIApplication {
    
    var searchView: SearchViewElements {
        return SearchViewElements(app: self)
    }
    
}

private struct SearchViewElements {
    
    let app: XCUIApplication

    var searchButton: XCUIElement {
        app.buttons["Search"]
    }

    var favoriteButton: XCUIElement {
        app.buttons["Add to favorite"]
    }

    var queryTextField: XCUIElement {
        app.textFields["Search..."]
    }

    var imageView: XCUIElement {
        app.images.element(boundBy: 0)
    }
    
}
