import XCTest
@testable import NSAttribeautiful

extension NSAttribeautifulTests {
    
    private static let noGroupContainerDocument = "No group container present"
    private static let incorrectlyFormattedContainerDocument = "≤[myFont123:green][anotherFont:12.3:blue≥"
    private static let correctlyFormattedContainerDocument = "≤[myFont:123:green][anotherFont:12.3:blue]≥"
    
    private func parseDocument(_ document: String) -> (container: GroupContainer?, error: NSAttribeautifulError?) {
        do {
            let container = try GroupContainerRetriever.groupContainerFor(document)
            return (container, nil)
        }
        catch let error {
            return (nil, error as? NSAttribeautifulError)
        }
    }
    
    func testDocumentWithNoGroupContainerReturnsError() {
        let document = NSAttribeautifulTests.noGroupContainerDocument
        XCTAssertTrue(parseDocument(document).error == .missingGroupContainer)
    }
    
    func testDocumentIncorrectlyFormattedGroupContainerReturnsError() {
        let document = NSAttribeautifulTests.incorrectlyFormattedContainerDocument
        XCTAssertTrue(parseDocument(document).error == .missingGroupContainer)
    }
    
    func testCorrectlyFormattedGroupContainerReturnsContainer() {
        let document = NSAttribeautifulTests.correctlyFormattedContainerDocument
        XCTAssertTrue(parseDocument(document).0 != nil)
    }
    
    func testCorrectlyFormattedGroupContainerReturnsCorrectNumberOfGroups() {
        let document = NSAttribeautifulTests.correctlyFormattedContainerDocument
        let expected = 2
        guard let container = parseDocument(document).container else {
            XCTAssertFalse(true)
            return
        }
        let count = container.groups.count
        XCTAssertEqual(expected, count)
    }

}
