import bb.cascades 1.4

Container {
    leftPadding: 20
    rightPadding: 20
    topPadding: 10
    bottomPadding: 10
    background: Color.create("#e6e6e6")
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
        Container { //task name
            Label { //task id here
                text: "Task Name"
                textStyle.fontSize: FontSize.PointValue
                textStyle.fontSizeValue: 8

            }
        }
        Container { // project name > list name
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                rightPadding: 10

                Label { // project name here
                    text: "Project name"
                    textStyle.color: Color.create("#c8c8c8")
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 5
                }
            }
            Container {
                verticalAlignment: VerticalAlignment.Center
                maxWidth: 2
                maxHeight: 15
                minHeight: 15
                minWidth: 2
                background: Color.Red

            }
            Container { // List id here
                leftPadding: 10
                Label {
                    text: "List Name"
                    textStyle.color: Color.create("#c8c8c8")
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 5
                }

            }
        }
        Container { // assignee and due date
            layout: StackLayout {

                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                layout: StackLayout {

                    orientation: LayoutOrientation.LeftToRight
                }
                Container {
                    verticalAlignment: VerticalAlignment.Center
                    ImageView { // assignee photo here
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
                    background: Color.create("#f8efc9")
                    Label { // assignee name here
                        text: "Assignee Name"
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 5
                    }

                }
            }
            Container {
                leftPadding: 5
                rightPadding: 5
                Label {
                    textStyle.color: Color.Red
                    text: "-"
                }
            }
            Container {
                leftPadding: 5
                rightPadding: 5
                bottomPadding: 5
                topPadding: 5
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                background: Color.create("#e6e6e6")
                Label { // due date here
                    text: "Due Date"
                    textStyle.fontSize: FontSize.PointValue
                    textStyle.fontSizeValue: 5
                }
            }
        }
    }

}
