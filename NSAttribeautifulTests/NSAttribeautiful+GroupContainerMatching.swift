import XCTest
@testable import NSAttribeautiful

extension NSAttribeautifulTests {
    
    func testDocumentWithNoGroupContainerReturnsError() {
        let document = "No group container present"
        do {
            let _ = try GroupContainerRetriever.groupContainerFor(document)
        }
        catch let error {
            XCTAssert(error as? NSAttribeautifulError == NSAttribeautifulError.missingGroupContainer)
            return
        }
        XCTAssert(false)
    }

}
