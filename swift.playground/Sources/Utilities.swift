import Foundation

@discardableResult public func assert(_ op: @autoclosure() -> Bool) -> String { op() ? "✅" : "🛑" }
