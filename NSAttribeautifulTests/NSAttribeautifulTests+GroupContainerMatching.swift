import XCTest
@testable import NSAttribeautiful

extension NSAttribeautifulTests {
    
    private static let noGroupContainerDocument = "No group container present"
    private static let incorrectlyFormattedContainerDocument = "≤[myFont123:green][anotherFont:12.3:blue≥"
    private static let correctlyFormattedContainerDocumentWithSpacing = "≤[myFont:123:green][anotherFont:12.3:blue][spacing:32]≥"
    private static let correctlyFormattedContainerDocumentWithoutSpacing = "≤[myFont:123:green][anotherFont:12.3:blue]≥"

    private func parseDocument(_ document: String) -> (container: GroupContainer?, error: NSAttribeautifulError?) {
        do {
            let container = try GroupContainerRetriever.groupContainerFor(document)
            return (container, nil)
        }
        catch let error {
            return (nil, error as? NSAttribeautifulError)
        }
    }
    
    func testDocumentWithNoGroupContainerThrowsError() {
        let document = NSAttribeautifulTests.noGroupContainerDocument
        XCTAssertTrue(parseDocument(document).error == .missingGroupContainer)
    }
    
    func testDocumentIncorrectlyFormattedGroupContainerThrowsError() {
        let document = NSAttribeautifulTests.incorrectlyFormattedContainerDocument
        XCTAssertTrue(parseDocument(document).error == .missingGroupContainer)
    }
    
    func testCorrectlyFormattedGroupContainerReturnsContainer() {
        let document = NSAttribeautifulTests.correctlyFormattedContainerDocumentWithSpacing
        XCTAssertTrue(parseDocument(document).0 != nil)
    }
    
    func testCorrectlyFormattedGroupContainerReturnsCorrectNumberOfGroups() {
        let document = NSAttribeautifulTests.correctlyFormattedContainerDocumentWithSpacing
        let expected = 2
        guard let container = parseDocument(document).container else {
            XCTAssertFalse(true)
            return
        }
        let count = container.groups.count
        XCTAssertEqual(expected, count)
    }
    
    func testCorrectlyFormattedGroupContainerReturnsCorrectLineSpacing() {
        let document = NSAttribeautifulTests.correctlyFormattedContainerDocumentWithSpacing
        let expected = 32
        guard let container = parseDocument(document).container else {
            XCTAssertFalse(true)
            return
        }
        let count = container.lineSpacing
        XCTAssertEqual(expected, count)
    }
    
    func testCorrectlyFormattedGroupContainerWithoutLineSpacingReturnsCorrectLineSpacing() {
        let document = NSAttribeautifulTests.correctlyFormattedContainerDocumentWithoutSpacing
        let expected = 0
        guard let container = parseDocument(document).container else {
            XCTAssertFalse(true)
            return
        }
        let count = container.lineSpacing
        XCTAssertEqual(expected, count)
    }

}
