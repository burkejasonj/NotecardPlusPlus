import Foundation
import SwiftUI

struct ChartItemView: View {
    var accentColor: Color = .indigo
    var name: String = "Placeholder"
    var points: Int = 500
    var body: some View {
        Capsule()
            .fill(
                LinearGradient(gradient: Gradient(colors: [
                    accentColor.adjust(brightness: 0.1), accentColor.adjust(brightness: -0.1)
                ]),
                               startPoint: .leading,
                               endPoint: .trailing)
            )
            .overlay(
                HStack {
                    Circle()
                    #if os(macOS)
                        .fill(Color(NSColor.windowBackgroundColor))
                    #else
                        .fill(Color(UIColor.systemBackground))
                    #endif
                        .padding(4)
                    Text(name)
                    Spacer()
                    Text("\(points)")
                        .padding()
                }
            )
            .frame(height: 30)
    }
}

struct ChartExampleView: View {
    var accentColor: Color = .indigo
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                ChartItemView(
                    accentColor: accentColor,
                    name: "CaptnJason",
                    points: 2022
                )
                .frame(width: geo.size.width * (2022 / 2022))
                ChartItemView(
                    accentColor: accentColor,
                    name: "JackLovesGod",
                    points: 2000
                )
                .frame(width: geo.size.width * (2000 / 2022))
                ChartItemView(
                    accentColor: accentColor,
                    name: "JJTommy",
                    points: 1984
                )
                .frame(width: geo.size.width * (1984 / 2022))
                ChartItemView(
                    accentColor: accentColor,
                    name: "TheCraftdalorian",
                    points: 1776
                )
                .frame(width: geo.size.width * (1776 / 2022))
                ChartItemView(
                    accentColor: accentColor,
                    name: "Vadez",
                    points: 1337
                )
                .frame(width: geo.size.width * (1337 / 2022))
                ChartItemView(
                    accentColor: accentColor,
                    name: "Ness18",
                    points: 1024
                )
                .frame(width: geo.size.width * (1024 / 2022))
            }
        }
    }
}
