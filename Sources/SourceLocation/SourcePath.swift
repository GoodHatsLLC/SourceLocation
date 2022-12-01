import Foundation

// MARK: - SourcePath

public struct SourcePath:
    Hashable,
    CustomStringConvertible,
    CustomDebugStringConvertible,
    Codable
{

    public init(
        location: SourceLocation,
        indexHashable: AnyHashable? = nil,
        upstream: SourcePath
    ) {
        path = upstream.path + [location.id]
        locationPath = upstream.locationPath + [location.description]
        info = location.info
        self.indexHashable = String(describing: indexHashable)
    }

    private init(root: SourceLocation) {
        path = [root.id]
        locationPath = [root.description]
        info = root.info
        indexHashable = nil
    }

    public let path: [String]
    public let locationPath: [String]
    public let indexHashable: String?

    public var description: String {
        path
            .joined(separator: " -> ") + ((indexHashable?.description).map { "[\($0)]" } ?? "") +
            (info.map { " (\($0))" } ?? "")
    }

    public var debugDescription: String {
        (info.map { $0 + " " } ?? "") + locationPath
            .joined(separator: " -> ") + ((indexHashable?.description).map { "[\($0)]" } ?? "") +
            (info.map { " (\($0))" } ?? "")
    }

    private let info: String?

}

extension SourcePath {

    public static let void = SourcePath(root: .void)

    public static func root(_ location: SourceLocation) -> SourcePath {
        SourcePath(root: location)
    }
}

extension SourcePath {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(path)
        hasher.combine(locationPath)
        hasher.combine(info)
        hasher.combine(indexHashable)
    }
}
