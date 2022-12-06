import SwiftUI

#if os(macOS)

struct EditButton: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Edit")
        }
        .buttonStyle(.borderless)
    }
}
#endif

struct listButtonStyle: ButtonStyle {
    var tint: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        withAnimation(.easeOut) {
            configuration.label
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(tint)
                        .opacity(configuration.isPressed == true ? 0.6 : 0)
                )
        }
    }
}

struct ncButtonStyle: ButtonStyle {
    var foregroundColor: Color
    var tint: Color
    var size: CGFloat
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(foregroundColor)
            .padding()
            .frame(width: size * 0.75)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(tint)
                    .opacity(configuration.isPressed == true ? 0.4 : 1.0)
            )
    }
}

class NumberInput: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}

extension View {
    @ViewBuilder
    func ifCondition<TrueContent: View, FalseContent: View>(
        _ condition: Bool,
        then trueContent: (Self) -> TrueContent,
        else falseContent: (Self) -> FalseContent
    ) -> some View {
        if condition {
            trueContent(self)
        } else {
            falseContent(self)
        }
    }
}

extension Color {
    init?(hex optHex: String?) {
        guard let hex = optHex else {
            return nil;
        }
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
#if os(macOS)
    func adjust(
        hue: CGFloat = 0,
        saturation: CGFloat = 0,
        brightness: CGFloat = 0,
        opacity: CGFloat = 1
    ) -> Color {
        let color = NSColor(self)
        
        return Color(
            hue: color.hueComponent + hue,
            saturation: color.saturationComponent + saturation,
            brightness: color.brightnessComponent + brightness,
            opacity: color.alphaComponent + opacity
        )
    }
    
    func toHex() -> String? {
        let uic = NSColor(self)
        guard let components = uic.cgColor.components,
              components.count >= 3
        else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(
                format: "%02lX%02lX%02lX%02lX",
                lroundf(r * 255),
                lroundf(g * 255),
                lroundf(b * 255),
                lroundf(a * 255)
            )
        } else {
            return String(
                format: "%02lX%02lX%02lX",
                lroundf(r * 255),
                lroundf(g * 255),
                lroundf(b * 255)
            )
        }
    }
#else
    func adjust(hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, opacity: CGFloat = 1) -> Color {
        let color = UIColor(self)
        var currentHue: CGFloat = 0
        var currentSaturation: CGFloat = 0
        var currentBrigthness: CGFloat = 0
        var currentOpacity: CGFloat = 0
        
        if color.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentOpacity) {
            return Color(hue: currentHue + hue, saturation: currentSaturation + saturation, brightness: currentBrigthness + brightness, opacity: currentOpacity + opacity)
        }
        return self
    }
    
    func toHex() -> String? {
        let uic = UIColor(self)
        guard let components = uic.cgColor.components,
              components.count >= 3
        else {
            return nil
        }
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if a != Float(1.0) {
            return String(
                format: "%02lX%02lX%02lX%02lX",
                lroundf(r * 255),
                lroundf(g * 255),
                lroundf(b * 255),
                lroundf(a * 255)
            )
        } else {
            return String(
                format: "%02lX%02lX%02lX",
                lroundf(r * 255),
                lroundf(g * 255),
                lroundf(b * 255)
            )
        }
    }
#endif
}

//struct UIList<Data, Row: View>: UIViewRepresentable {
//    private let content: (Data) -> Row
//    private let data: [Data]
//
//    init(_ data: [Data], _ content: @escaping (Data) -> Row) {
//        self.data = data
//        self.content = content
//    }
//
//    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {
//        private let content: (Data) -> Row
//        var data: [Data]
//
//        init(_ data: [Data], _ content: @escaping (Data) -> Row) {
//            self.data = data
//            self.content = content
//        }
//
//        func tableView(
//            _ tableView: UITableView,
//            numberOfRowsInSection section: Int
//        ) -> Int {
//            data.count
//        }
//
//        func tableView(
//            _ tableView: UITableView,
//            cellForRowAt indexPath: IndexPath
//        ) -> UITableViewCell {
//            guard let tableViewCell = tableView.dequeueReusableCell(
//                withIdentifier: "Cell",
//                for: indexPath
//            ) as? HostingCell<Row> else {
//                return UITableViewCell()
//            }
//            let data = self.data[indexPath.row]
//            let view = content(data)
//            tableViewCell.setup(with: view)
//            return tableViewCell
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(data, content)
//    }
//
//    func updateUIView(_ uiView: UITableView, context: Context) {
//        context.coordinator.data = data
//        uiView.reloadData()
//    }
//
//    func makeUIView(context: Context) -> UITableView {
//        let tableView = UITableView()
//        tableView.allowsMultipleSelection = false
//        tableView.allowsMultipleSelectionDuringEditing = true
//        tableView.separatorStyle = .none
//        tableView.delegate = context.coordinator
//        tableView.dataSource = context.coordinator
//        tableView.register(
//            HostingCell<Row>.self,
//            forCellReuseIdentifier: "Cell"
//        )
//        return tableView
//    }
//}
//
//private class HostingCell<Content: View>: UITableViewCell {
//    var host: UIHostingController<Content>?
//
//    func setup(with view: Content) {
//        if host == nil {
//            let controller = UIHostingController(rootView: view)
//            host = controller
//
//            guard let content = controller.view else { return }
//            content.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(content)
//
//            content.topAnchor.constraint(
//                equalTo: contentView.topAnchor
//            ).isActive = true
//            content.leftAnchor.constraint(
//                equalTo: contentView.leftAnchor
//            ).isActive = true
//            content.bottomAnchor.constraint(
//                equalTo: contentView.bottomAnchor
//            ).isActive = true
//            content.rightAnchor.constraint(
//                equalTo: contentView.rightAnchor
//            ).isActive = true
//        } else {
//            host?.rootView = view
//        }
//
//        setNeedsLayout()
//    }
//}
