//
//  NSAttribeautiful.swift
//  
//
//  Created by Henry Cooper on 30/01/2021.
//

import Foundation

public class NSAttribeautiful {
    
    let document: String
    private let customPrefix: Character?
    private let customSuffix: Character?
    
    /// Creates an instance of NSAttribeautiful
    /// - Parameters:
    ///   - document: The `String` containing unformatted text.
    ///   - customPrefix: A custom value for the token that encloses the beginning of a `GroupContainer` or subsequent arguments to style.
    ///   - customSuffix: A custom value for the token that encloses the end of a `GroupContainer` or subsequent arguments to style.
    public init(document: String, customPrefix: Character? = nil, customSuffix: Character? = nil) {
        self.document = document
        self.customPrefix = customPrefix
        self.customSuffix = customSuffix
        DebugLogger.log(message: "For usage info, please visit https://github.com/pillboxer/NSAttribeautiful")
    }
    
    /// Applies the desired formatting to the document.
    /// - Returns: A correctly formatted `NSAttributedString`
    /// - throws: An `NSAttribeautifulError` if the `document` does not contain a valid `GroupContainer` or valid `Group` objects within the container
    public func beautifiedDocument() throws -> NSAttributedString {
        RegexPattern.useCustomPrefix(customPrefix)
        RegexPattern.useCustomSuffix(customSuffix)
        do {
            try checkTokenLegality()
            let container = try GroupContainerRetriever.groupContainerFor(document)
            let styles = container.groups.map { GroupStyle(group: $0) }
            return StyleApplicator.attributedString(from: document, styles: styles, spacing: container.lineSpacing)
        }
        catch let error {
            throw error
        }
    }
    
    private func checkTokenLegality() throws {
        if RegexPattern.prefixToken == RegexPattern.suffixToken {
            throw NSAttribeautifulError.identicalTokens
        }
    }
}
