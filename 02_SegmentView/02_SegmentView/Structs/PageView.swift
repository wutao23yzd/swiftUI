//
//  PageView.swift
//  02_SegmentView
//
//  Created by admin on 2024/2/20.
//

import SwiftUI


public struct PageView<Page: View>: View {
    
    let content: (Int) -> Page
    private var items = [String]()
    private var onDidSelect: ((Int) -> Void)?
    @Binding private var selectedIndex: Int
    
    public init(items: [String],
                selectedIndex: Binding<Int> = .constant(Int.max),
                content: @escaping (Int) -> Page) {
        _selectedIndex = selectedIndex
        self.content = content
        self.items = items
       
    }
    
    public var body: some View {
        PagingController(
            items: items,
            onDidSelect: onDidSelect,
            content: content,
            selectedIndex: $selectedIndex)
    }
    
    public func didSelect(_ action: @escaping (Int) -> Void) -> Self {
        var view = self
        view.onDidSelect = action
        return view
    }
    
    struct PagingController: UIViewControllerRepresentable {
        let items: [String]
        var onDidSelect: ((Int) -> Void)?
        let content: (Int) -> Page
        private let segmentedView = JXSegmentedView()
        private let dataSource = JXSegmentedTitleDataSource()
        @Binding var selectedIndex: Int
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<PagingController>) -> UIViewController {
            
            
            dataSource.isTitleColorGradientEnabled = true
            dataSource.titles = items
            
            let indicator = JXSegmentedIndicatorLineView()
            indicator.indicatorWidth = 20
            
            let containerViewController = UIViewController()
         
            segmentedView.dataSource = dataSource
            segmentedView.delegate = context.coordinator
            segmentedView.indicators = [indicator]
   
            
            let listContainer = JXSegmentedListContainerView(dataSource: context.coordinator)
            containerViewController.view.addSubview(segmentedView)
            containerViewController.view.addSubview(listContainer)
            listContainer.backgroundColor = .yellow
            segmentedView.listContainer = listContainer
            
            segmentedView.frame = CGRectMake(0, 40, UIScreen.main.bounds.size.width, 40)
            listContainer.frame = CGRect(x: 0, y: segmentedView.frame.maxY, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - segmentedView.frame.maxY)
            segmentedView.setNeedsLayout()
            segmentedView.layoutIfNeeded()
            return containerViewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
  
            guard selectedIndex != Int.max else {
                return
            }
            segmentedView.selectItemAt(index: selectedIndex)
        }
        
        class Coordinator: JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {
            
            var parent: PagingController

            init(_ parent: PagingController) {
                self.parent = parent
            }

            func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
                      
                parent.onDidSelect?(index)
            }
            
            func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
                return parent.items.count
            }
            
            func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
                let view = parent.content(index)
                let hostingViewController = HostingControllerListAdapter(rootView: view)
                return hostingViewController
            }
        }
    }
}



class HostingControllerListAdapter: JXSegmentedListContainerViewListDelegate {
    private var hostingController: UIHostingController<AnyView>?

    init<T: View>(rootView: T) {
        self.hostingController = UIHostingController(rootView: AnyView(rootView))
    }

    func listView() -> UIView {
        return hostingController?.view ?? UIView()
    }
}
