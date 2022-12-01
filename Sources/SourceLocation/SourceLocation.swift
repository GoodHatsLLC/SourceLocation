import CryptoKit
import Foundation

// MARK: - SourceLocation

public struct SourceLocation: CustomStringConvertible, Hashable {

    public init(fileID: String, line: Int, column: Int, info: String? = nil) {
        self.fileID = "\(fileID)"
        self.line = Int(line)
        self.column = Int(column)
        self.info = info
        let sourceLocation = "\(fileID):\(line):\(column)"
        self.sourceLocation = sourceLocation
        id = Self.sha(value: sourceLocation)
    }

    private init() {
        let fileID = "/dev/null"
        let line = -1
        let column = -1
        self.fileID = fileID
        self.line = line
        self.column = column
        let sourceLocation = "\(fileID):\(line):\(column)"
        self.sourceLocation = sourceLocation
        id = "VOID"
        info = "SourceLocation.void"
    }

    public static let void = SourceLocation()

    public let fileID: String
    public let line: Int
    public let column: Int
    public let sourceLocation: String
    public let id: String
    public let info: String?

    public var description: String {
        sourceLocation
    }

    public static func here(
        fileID: String = #fileID,
        line: Int = #line,
        column: Int = #column,
        info: String? = nil
    )
        -> SourceLocation
    {
        .init(fileID: fileID, line: line, column: column, info: info)
    }

}

extension SourceLocation {
    static func sha(value: String) -> String {
        var hash = SHA256()
        hash.update(
            data: value.data(using: .utf8) ?? Data()
        )
        return hash
            .finalize()
            .map { "\($0)" }
            .joined()
    }
}
