//
//  ContentView.swift
//  PAWS
//
//  Created by kimjihee on 6/17/24.
//

import SwiftUI
import AxisSegmentedView

struct ContentView: View {
    @State private var isStoreButtonTapped = false
    @State private var selectedTab: Int = 0
    @State var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    title
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        room
                        pointSection
                            .padding(16)
                        
                    }
                    subTitle
                    customSegmentedView
                    itemView
                }
                
            }
            .padding(16)
            .background {
                LinearGradient( colors: [Color.accentColor.opacity(0.4), Color.white.opacity(0.67)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    ContentView()
}

extension ContentView {
    
    private var pointSection: some View {
        HStack {
            Circle()
                .foregroundColor(Color.white)
                .overlay {
                    Image(systemName: "pawprint.fill")
                        .font(.caption2)
                        .foregroundColor(Color.accentColor)
                }
                .frame(height: 20)
                .padding(5)
                .padding(.trailing, -5)
            Text("11")
                .font(.pretendardMedium16)
                .fontWeight(.regular)
                .padding(.trailing, 18)
        }
        .background(Color.white.opacity(0.4))
        .cornerRadius(50)
    }
    
    private var title: some View {
        Text("PawRoom")
            .font(.pretendardBold18)
            .foregroundColor(Color.black)
    }
    
    private var storeButton: some View {
        Button{
            isStoreButtonTapped = true
        } label: {
            Image(systemName: "storefront.fill")
                .font(.pretendardBold18)
                .foregroundColor(Color.black)
        }
        .navigationDestination(isPresented: $isStoreButtonTapped) {
            StoreView()
        }
    }
    
    private var room: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Color.white, lineWidth: 1)
//            .foregroundColor(Color.white.opacity(0.9))
            .frame(height: 340)
            .overlay {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.white.opacity(0.3))
                    .padding(5)
            }
        
    }
    
    private var subTitle: some View {
        HStack {
            Text("What's in my room")
                .font(.pretendardBold18)
            Spacer()
//            Rectangle()
//                .foregroundColor(Color.black.opacity(0.5))
//                .frame(width: 140, height: 0.6)
//            Spacer()
            storeButton
        }
        .padding(.top, 30)
        .padding(.bottom, 10)
    }
    
    private var customSegmentedView: some View {
        ZStack {
//            RoundedRectangle(cornerRadius: 50)
//                .foregroundColor(Color.gray.opacity(0.2))
//                .frame(height: 40)
            
            AxisSegmentedView(selection: $selectedTab, constant: .init()) {
                Group{
                    Text("All")
                        .itemTag(0, selectArea: 0) {
                            Text("All")
                                .foregroundColor(Color.white)
                        }
                    Text("캐릭터")
                        .itemTag(1, selectArea: 0) {
                            Text("캐릭터")
                                .foregroundColor(Color.white)
                        }
                    Text("인테리어")
                        .itemTag(2, selectArea: 0) {
                            Text("인테리어")
                                .foregroundColor(Color.white)
                        }
                }
                .foregroundColor(Color.black)
                .font(.pretendardMedium16)
            } style: {
                ASCapsuleStyle(backgroundColor: Color.white, foregroundColor: Color.accentColor, animation: .bouncy)
            } onTapReceive: { selectedTab in
                print("---------------------")
                print("Selection : ", selectedTab)
            }
            .frame(height: 40)
        }
    }
    
    private var itemView: some View {
        ScrollView {
              LazyVGrid(columns: columns) {
                ForEach((0...19), id: \.self) { _ in
                  Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1))
                    .cornerRadius(14)
                    .frame(width: 84, height: 84)
                    .padding()
                }
              }
            }
    }
    
}
