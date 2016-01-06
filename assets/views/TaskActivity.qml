import bb.cascades 1.3
import bb.system 1.2

Container {
    leftPadding: 20
    rightPadding: 20
    topPadding: 40
    Container {
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill

        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                ImageView { //user image here
                    imageSource: "asset:///images/BBicons/ic_contact.png"
                }
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                layout: StackLayout {
                    orientation: LayoutOrientation.TopToBottom
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    Label { // username here
                        text: "Name"
                    }
                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Left
                    verticalAlignment: VerticalAlignment.Center
                    Label { // activity time here
                        text: "Date/time"
                        opacity: .5
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6
                    }
                }
            }
        }
        Container {
            horizontalAlignment: HorizontalAlignment.Left
            verticalAlignment: VerticalAlignment.Center
            leftPadding: 30
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                leftPadding: 10
                rightPadding: 10
                bottomPadding: 5
                background: Color.create("#fff8f0d0")
                Label { //old ststus here
                    text: "Old Status"
                    opacity: .5
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 6
                }
            }
            Container {
                leftPadding: 5
                rightPadding: 5
                Label {
                    text: ">"
                }
            }
            Container {
                leftPadding: 10
                rightPadding: 10
                bottomPadding: 5
                background: Color.create("#fff8e38c")

                Label { // new ststus here
                    text: "New Status"
                    opacity: .5
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 6
                }
            }
        }
    }
}