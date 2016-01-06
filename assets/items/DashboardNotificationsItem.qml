import bb.cascades 1.4

Container {
    property alias title: notificationtitle.text
    property alias des: extrainfo.text
    property alias status: moreinfo.text
    leftPadding: 10
    rightPadding: 10
    topPadding: 5
    bottomPadding: 5
    background: Color.create("#e6e6e6")
    horizontalAlignment: HorizontalAlignment.Fill
    verticalAlignment: VerticalAlignment.Fill
    Container {
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill
        leftPadding: 10
        bottomPadding: 10
        rightPadding: 10
        topPadding: 5
        layout: StackLayout {
            orientation: LayoutOrientation.TopToBottom
        }
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                maxWidth: 50
                maxHeight: 50
                ImageView { //notification type
                    imageSource: "asset:///images/BBicons/ic_notification.png"
                    filterColor: Color.Gray
                }
            }
            Container {
                Label { //Notification Title
//                    text: "Notification Title"
                    id: notificationtitle
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 7

                }
            }

        }

        Container { // assignee and due date
            layout: StackLayout {

                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                leftPadding: 50
                layout: StackLayout {

                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    ImageView { // user photo here
                        maxHeight: 40
                        maxWidth: 40
                        imageSource: "asset:///images/BBicons/ic_contact.png"
                        filterColor: Color.Red

                    }
                }
                Container {
                    leftPadding: 5
                    rightPadding: 5
                    bottomPadding: 5
                    topPadding: 5
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Center
                    Label { // user name here
//                        text: "Assignee Name"
                        id: extrainfo
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6
                    }

                }
            }
            Container {
                Label {
                    textStyle.color: Color.Red
                    text: ":"
                }
            }
            Container {
                leftPadding: 5
                rightPadding: 5
                bottomPadding: 5
                topPadding: 5
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                Label { // Notification here
//                    text: "Notification"
                    id: moreinfo
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 6
                }
            }
        }
    }

}
