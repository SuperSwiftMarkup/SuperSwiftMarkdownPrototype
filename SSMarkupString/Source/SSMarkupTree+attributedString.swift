//
//  File.swift
//  
//
//  Created by Colbyn Wadman on 1/19/25.
//

import Foundation

// MARK: - PUBLIC API -
extension SSMarkupTree {
    public func attributedString() -> NSAttributedString {
        fatalError("TODO")
    }
}

// MARK: - INTERNAL -

fileprivate extension SSMarkupTree {
    func _attributedString(context: Context, environment: Environment) {
        switch self {
        case .displayString(let displayString):
            switch displayString {
            case .text(let string):
                context.append(string: string)
            case .token(let string):
                context.append(string: string)
            case .preformatted(let string):
                context.append(string: string)
            }
        case .lineBreak(let lineBreakType):
            context.append(lineBreak: lineBreakType)
        case .scope(let scope, let subtree):
            fatalError("TODO")
        case .style(let styles, let subtree):
            fatalError("TODO")
        case .indent(let blockIndentMode, let subtree):
            let subEnvironment: Environment
            switch blockIndentMode {
            case .whole(let ratio):
                subEnvironment = environment.include(baseIndentationLevel: ratio)
            case .trailing(let ratio):
                subEnvironment = environment.include(trailingIndentationLevel: ratio)
            }
            subtree._attributedString(context: context, environment: subEnvironment)
        case .fragment(let array):
            Self.processSequence(context: context, environment: environment, sequence: array)
        }
    }
    static func processSequence(context: Context, environment: Environment, sequence: [SSMarkupTree]) {
        for element in sequence {
            
        }
    }
}

fileprivate final class Context {
    private let buffer = NSMutableAttributedString()
    private var currentBlock = NSMutableAttributedString()
    private var scopes: [ SSScopeRange ] = []
    func append(string: String) {
        currentBlock.append(NSAttributedString(string: string))
    }
    func append(lineBreak: SSMarkupTree.LineBreakType) {
        switch lineBreak {
        case .softLineBreak:
            append(string: "\n")
            beginNewBlock() // TODO: SHOULD BE BEGIN A NEW BLOCK FOR SOFT LINE BREAKS?
        case .hardLineBreak:
            append(string: "\n")
            beginNewBlock()
        case .paragraphBreak:
            append(string: "\n\n")
            beginNewBlock()
        }
    }
    private func beginNewBlock() {
        self.buffer.append(self.currentBlock)
        self.currentBlock = NSMutableAttributedString()
    }
}

fileprivate struct Environment {
    var fontSize: CGFloat? = nil
    var fontWeight: SSStyle.Weight? = nil
    var fontDesign: SSStyle.Design? = nil
    var emphasis: SSStyle.Emphasis? = nil
    var foregroundColor: XColor? = nil
    var backgroundColor: XColor? = nil
    var baseIndentationLevel: Log<SSRatio>? = nil
    var trailingIndentationLevel: Log<SSRatio>? = nil
}

fileprivate struct Log<Element> {
    private var array: Array<Element>
    static var empty: Log<Element> {
        Log<Element>.init(array: [])
    }
    func append(_ newElement: Element) -> Log<Element> {
        var copy = self
        copy.array.append(newElement)
        return copy
    }
}

extension Environment {
    func with(fontSize: CGFloat?) -> Environment {
        var copy = self
        copy.fontSize = fontSize ?? copy.fontSize
        return copy
    }
    func with(fontWeight: SSStyle.Weight?) -> Environment {
        var copy = self
        copy.fontWeight = fontWeight ?? copy.fontWeight
        return copy
    }
    func with(fontDesign: SSStyle.Design?) -> Environment {
        var copy = self
        copy.fontDesign = fontDesign ?? copy.fontDesign
        return copy
    }
    func with(emphasis: SSStyle.Emphasis?) -> Environment {
        var copy = self
        copy.emphasis = emphasis ?? copy.emphasis
        return copy
    }
    func with(foregroundColor: XColor?) -> Environment {
        var copy = self
        copy.foregroundColor = foregroundColor ?? copy.foregroundColor
        return copy
    }
    func with(backgroundColor: XColor?) -> Environment {
        var copy = self
        copy.backgroundColor = backgroundColor ?? copy.backgroundColor
        return copy
    }
    func include(baseIndentationLevel: SSRatio) -> Environment {
        var copy = self
        copy.baseIndentationLevel = (copy.baseIndentationLevel ?? .empty).append(baseIndentationLevel)
        return copy
    }
    func include(trailingIndentationLevel: SSRatio) -> Environment {
        var copy = self
        copy.trailingIndentationLevel = (copy.trailingIndentationLevel ?? .empty).append(trailingIndentationLevel)
        return copy
    }
}

