import XCTest
import SwiftTreeSitter
import TreeSitterYaml

final class TreeSitterYamlTests: XCTestCase {
    func testCanLoadGrammar() throws {
        let parser = Parser()
        let language = Language(language: tree_sitter_yaml())
        XCTAssertNoThrow(try parser.setLanguage(language),
                         "Error loading Yaml grammar")
    }
}
