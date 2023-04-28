//
//  PreviewHelper.swift
//  BullsEye
//
//  Created by lyfeoncloudnine on 2023/04/28.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI
import UIKit

public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    public init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // MARK: UIViewRepresentable
    public func makeUIView(context: Context) -> UIView {
        return view
    }
    
    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    
    public init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }
    
    // MARK: - UIViewControllerRepresentable
    public func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
    
    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {
        
    }
}
#endif
