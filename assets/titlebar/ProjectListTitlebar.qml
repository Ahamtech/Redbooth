import bb.cascades 1.4
TitleBar {
    kind: TitleBarKind.FreeForm
    kindProperties: FreeFormTitleBarKindProperties {
        Container {
            leftPadding: 30
            rightPadding: 30
            background: Color.create("#21a5b8")
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    maxWidth: 100
                    maxHeight: 100
                    minHeight: 100
                    minWidth: 100
                    ImageView {
                        imageSource: "asset:///iconw.png"
                    }
                }
                Container {
                    leftPadding: 30
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    Label {
                        text: "Projects"
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 10
                        opacity: .8
                        textStyle.color: Color.White

                    }
                }
            }
            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                horizontalAlignment: HorizontalAlignment.Right
                verticalAlignment: VerticalAlignment.Center
                maxWidth: 60
                maxHeight: 60
                ImageView {
                    imageSource: "asset:///images/BBicons/ic_search.png"
                }
            }
        }
    }
}