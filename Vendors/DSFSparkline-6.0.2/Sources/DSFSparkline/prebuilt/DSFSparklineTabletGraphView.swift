//
//  DSFSparklineTabletGraphView.swift
//  DSFSparklines
//
//  Created by Darren Ford on 25/01/21.
//  Copyright © 2021 Darren Ford. All rights reserved.
//
//  MIT license
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial
//  portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
//  OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import Foundation
import CoreGraphics

#if os(macOS)
import AppKit
#else
import UIKit
#endif

/// A tablet-style sparkline. Similar to win/loss except rendering as a row of filled/unfilled circles
@objc public class DSFSparklineTabletGraphView: DSFSparklineDataSourceView {

	let overlay = DSFSparklineOverlay.Tablet()

	static let clear: CGColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0, 0, 0, 0])!

	/// The width of the stroke for the tablet
	@objc public dynamic var lineWidth: CGFloat = 1.0 {
		didSet {
			self.updateDisplay()
		}
	}

	/// The spacing (in pixels) between each bar
	@objc public dynamic var barSpacing: CGFloat = 1.0 {
		didSet {
			self.updateDisplay()
		}
	}

	#if os(macOS)
	/// The color to draw the 'win' boxes
	@objc public dynamic var winColor: NSColor = NSColor.systemGreen {
		didSet {
			self.colorDidChange()
		}
	}

	/// The color to draw the 'loss' boxes
	@objc public dynamic var lossColor: NSColor = NSColor.systemRed {
		didSet {
			self.colorDidChange()
		}
	}
	#else
	/// The color to draw the 'win' boxes
	@objc public dynamic var winColor: UIColor = UIColor.systemGreen {
		didSet {
			self.colorDidChange()
		}
	}

	/// The color to draw the 'loss' boxes
	@objc public dynamic var lossColor: UIColor = UIColor.systemRed {
		didSet {
			self.colorDidChange()
		}
	}
	#endif

	public override init(frame: CGRect) {
		super.init(frame: frame)
		self.configure()
	}

	public required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.configure()
	}

	func configure() {
		self.addOverlay(self.overlay)
		self.overlay.setNeedsDisplay()
	}

	override func colorDidChange() {
		super.colorDidChange()

		self.overlay.lineWidth = self.lineWidth
		self.overlay.tabletSpacing = self.barSpacing		// backwards compatible naming here

		self.overlay.winFill = DSFSparkline.Fill.Color(self.winColor.withAlphaComponent(0.3).cgColor)
		self.overlay.winStrokeColor = self.winColor.cgColor

		self.overlay.lossStrokeColor = self.lossColor.cgColor
	}
}
