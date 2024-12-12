//
//  ZoomableScrollView.swift
//  CV Builder
//
//  Created by Andrii Fomichov on 04.12.2024.
//

import SwiftUI

struct ZoomableScrollView<Content: View>: UIViewRepresentable {
    
    @Binding var scale: CGFloat
  private var content: Content
    var called = false
    var minimumScale: CGFloat
    var maximumScale: CGFloat
    var backgroundColor = Color.clear

    init(scale: Binding<CGFloat>, minimumScale: CGFloat = 1.0, maximumScale: CGFloat = 2.0, backgroundColor: Color = .clear, @ViewBuilder content: () -> Content) {
        self.content = content()
        self._scale = scale
        self.minimumScale = minimumScale
        self.maximumScale = maximumScale
        self.backgroundColor = backgroundColor
  }

  func makeUIView(context: Context) -> UIScrollView {
    // set up the UIScrollView
    let scrollView = UIScrollView()
    scrollView.delegate = context.coordinator  // for viewForZooming(in:)
      scrollView.maximumZoomScale = maximumScale
      scrollView.minimumZoomScale = minimumScale
      scrollView.zoomScale = scale
    scrollView.bouncesZoom = true
      scrollView.showsVerticalScrollIndicator = false
      scrollView.showsHorizontalScrollIndicator = false
      scrollView.backgroundColor = .clear
      
    // create a UIHostingController to hold our SwiftUI content
    let hostedView = context.coordinator.hostingController.view!
    hostedView.translatesAutoresizingMaskIntoConstraints = true
    hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    hostedView.frame = scrollView.bounds
      hostedView.backgroundColor = UIColor(backgroundColor)
      
    scrollView.addSubview(hostedView)

      
    return scrollView
  }

  func makeCoordinator() -> Coordinator {
      return Coordinator(self, hostingController: UIHostingController(rootView: self.content))
  }

  func updateUIView(_ uiView: UIScrollView, context: Context) {
    // update the hosting controller's SwiftUI content
      print("Called updated view")
    context.coordinator.hostingController.rootView = self.content
//    assert(context.coordinator.hostingController.view.superview == uiView)
      print("Scale " + String(Float(CGFloat(scale))))

      if uiView.zoomScale != scale {
          uiView.zoomScale = scale
      }
  }

  // MARK: - Coordinator

  class Coordinator: NSObject, UIScrollViewDelegate {
      var parent: ZoomableScrollView
    var hostingController: UIHostingController<Content>

    init(_ parent: ZoomableScrollView, hostingController: UIHostingController<Content>) {
      self.hostingController = hostingController
        self.parent = parent
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return hostingController.view
    }
      
      func scrollViewDidZoom(_ scrollView: UIScrollView) {
          DispatchQueue.main.async {
//              self.parent.scale = scrollView.zoomScale
          }
      }
  }
}
