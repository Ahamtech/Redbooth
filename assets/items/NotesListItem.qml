import bb.cascades 1.3

Container {
    property alias  title: name.text
    property alias  timer: datetime.text
    horizontalAlignment: HorizontalAlignment.Fill
    leftPadding: 10
    rightPadding: 10
    bottomPadding: 5
    topPadding: 5
    background: Color.create("#e6e6e6")
    Container {
        leftPadding: 20
        topPadding: 5
        bottomPadding: 10
        rightPadding: 20
        background: Color.White
        horizontalAlignment: HorizontalAlignment.Fill
        Label {
            text: "Notes Name"
            id: name
            textStyle.fontSize: FontSize.PointValue
            textStyle.fontSizeValue: 10
            textStyle.fontWeight: FontWeight.W200
        }
        Label {
            id: datetime
//            text: "jun er 2123"
        }
    }
}