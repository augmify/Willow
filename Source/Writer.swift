//
//  Writer.swift
//
//  Copyright (c) 2015-2016 Nike, Inc. (https://www.nike.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

// MARK: Writer

/**
    The Writer protocol defines a single API for writing a message. The message can be written in any way the
    conforming object sees fit. For example, it could write to the console, write to a file, remote log to a third
    party service, etc.
*/
public protocol Writer {
    func writeMessage(message: String, logLevel: LogLevel, formatters: [Formatter]?)
}

// MARK: -

/**
    The ConsoleWriter class runs all formatters in the order they were created and prints the resulting message
    to the console.
*/
public class ConsoleWriter: Writer {

    /**
        Initializes a console writer instance.

        - returns: A new console writer instance.
    */
    public init() {}

    /**
        Writes the message to the console using the global `print` function.

        Each formatter is run over the message in the order they are provided before writing the message to
        the console.

        - parameter message:    The original message to write to the console.
        - parameter logLevel:   The log level associated with the message.
        - parameter formatters: The formatter objects to run over the message before writing to the console.
    */
    public func writeMessage(message: String, logLevel: LogLevel, formatters: [Formatter]?) {
        var mutableMessage = message
        formatters?.forEach { mutableMessage = $0.formatMessage(mutableMessage, logLevel: logLevel) }

        print(mutableMessage)
    }
}
