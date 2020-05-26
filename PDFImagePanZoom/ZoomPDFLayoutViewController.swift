//
//  ZoomPDFLayoutViewController.swift
//  iOS9SDK
//
//  Created by Don Mag on 5/26/20.
//  Copyright © 2020 Don Mag. All rights reserved.
//

import UIKit

class ZoomPDFLayoutViewController: UIViewController, UIScrollViewDelegate {

	@IBOutlet var scrollView: UIScrollView!
	@IBOutlet var containerView: UIView!
	@IBOutlet var containerViewBottomConstraint: NSLayoutConstraint!
	@IBOutlet var containerViewLeadingConstraint: NSLayoutConstraint!
	@IBOutlet var containerViewTopConstraint: NSLayoutConstraint!
	@IBOutlet var containerViewTrailingConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		scrollView.delegate = self
		scrollView.minimumZoomScale = 0.1
		scrollView.maximumZoomScale = 5.0
		
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		updateMinZoomScaleForSize(view.bounds.size)
	}
	
	func updateMinZoomScaleForSize(_ size: CGSize) {
		let widthScale = size.width / containerView.bounds.width
		let heightScale = size.height / containerView.bounds.height
		let minScale = min(widthScale, heightScale)
		
		scrollView.minimumZoomScale = minScale
		scrollView.zoomScale = minScale
	}
	
	func scrollViewDidZoom(_ scrollView: UIScrollView) {
		updateConstraintsForSize(view.bounds.size)
	}
	
	func updateConstraintsForSize(_ size: CGSize) {
		let yOffset = max(0, (size.height - containerView.frame.height) / 2)
		containerViewTopConstraint.constant = yOffset
		containerViewBottomConstraint.constant = yOffset
		
		let xOffset = max(0, (size.width - containerView.frame.width) / 2)
		containerViewLeadingConstraint.constant = xOffset
		containerViewTrailingConstraint.constant = xOffset

		view.layoutIfNeeded()
	}
	
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return containerView
	}
	
	@IBAction func sampleButtonTapped(_ sender: Any) {
		print("Sample Button was Tapped!")
	}
	
	
}
