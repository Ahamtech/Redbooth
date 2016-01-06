import bb.cascades 1.3
import bb.system 1.2
import "../titlebar"
import "../views"
import "../moment.js" as Moment
Page {
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
    actionBarVisibility: ChromeVisibility.Default
    resizeBehavior: PageResizeBehavior.None
    titleBar: TaskViewTitlebar {

    }
    onCreationCompleted: {
        render()
        lname.text = activetask.title
    }
    function render (){
        var info = activetask
        name.text = info.name
        pname.text = activeproject.name
        if (info.assigned_id) {
            var inas = Qt.getIdfromUserId(info.assigned_id)
            console.log("info")
            console.log(inas)
            console.log(Qt.getUserNameFromId(inas))
            aname.text = Qt.getUserNameFromId(inas)
        }
        if (info.due_on) {
            ddate.text = info.due_on
        }
        getComments()
    }
    Container {
        Container {
            topPadding: 20
            leftPadding: 20
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }

            Container {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                Container {
                    Label { // project name here
                        text: "Project Name"
                        id: pname
                        opacity: .5
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6

                    }
                }
                Container {
                    leftPadding: 5
                    rightPadding: 5
                    Label {
                        opacity: .5
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6
                        text: "-"
                    }
                }
                Container {
                    Label { // List name here
                        id: lname
                        text: "List Name"
                        opacity: .5
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6

                    }
                }
            }

            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: -1
                }
                Container {
                    rightPadding: 30
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Container {
                        maxWidth: 50
                        maxHeight: 50
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        ImageView {

                            imageSource: "asset:///images/BBicons/ic_contact.png"
                        }
                    }
                    Container {
                        verticalAlignment: VerticalAlignment.Center
                        horizontalAlignment: HorizontalAlignment.Center
                        Label { // member count here

                            text: "3"
                        }
                    }
                }

            }
        }
        Container {
            leftPadding: 30
            rightPadding: 10
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                rightPadding: 20
                scaleX: .8
                scaleY: .8
                CheckBox {

                }
            }
            Container {

                Label { //Task name here
                    multiline: true
                    text: "Task Name"
                    id: name
                }
            }
        }

        Divider {

        }
        Container {
            leftPadding: 50
            rightPadding: 50
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                layoutProperties: StackLayoutProperties {
                    spaceQuota: .3
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Center

                    text: "No Assigned"
                    id: aname
                    textStyle.color: Color.create("#21a5b8")

                }
            }
            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: .3

                }
                verticalAlignment: VerticalAlignment.Fill
                maxHeight: 40
                minHeight: 40
                maxWidth: 2
                minWidth: 2
                background: Color.Red
            }
            Container {
                horizontalAlignment: HorizontalAlignment.Center
                verticalAlignment: VerticalAlignment.Center
                layoutProperties: StackLayoutProperties {
                    spaceQuota: .3
                }
                Label {
                    horizontalAlignment: HorizontalAlignment.Center

                    text: "No Due Date "
                    id: ddate
                    textStyle.color: Color.create("#21a5b8")

                }
            }
        }
        Divider {

        }
        ListView {
            dataModel: ArrayDataModel {

            }
            id: comments
            onTriggered: {
                notespane.push(notespage.createObject())
            }
            listItemComponents: [
                ListItemComponent {
                    type: ""
                    CustomListItem {

                        ConversationComment {
                            title: Qt.getUserNameFromId(ListItemData.user_id)
                            comment: ListItemData.body
                            time: Moment.moment.unix(ListItemData['updated_at']).format('lll')
                            image: Qt.app.isImageAvailabel(ListItemData['user_id'])
                            onCreationCompleted: {
                                console.log(JSON.stringify(ListItemData))
                            }
                        }
                    }
                }
            ]

        }

    }
    attachedObjects: [
        SystemPrompt {
            id: commentbox
            title: qsTr("Enter Comment")
            rememberMeChecked: false
            includeRememberMe: false
            confirmButton.enabled: true
            cancelButton.enabled: true
            inputField.emptyText: qsTr("Comment")
            onFinished: {
                if (result == SystemUiResult.ConfirmButtonSelection) {
                    postComments(commentbox.inputFieldTextEntry())
                }
            }
        },
        SystemDialog {
            id: deleteTaskDilog
            title: qsTr("Delete")
            body: qsTr("Do you want to Delete this item ?")
            confirmButton.enabled: true
            confirmButton.label: qsTr("Yes")
            cancelButton.enabled: true
            onFinished: {
                if (result == SystemUiResult.ConfirmButtonSelection) {
                    deleteTask()
                }
            }
        },
        SystemPrompt {
            id: edit
            title: qsTr("edit Title")
            rememberMeChecked: false
            includeRememberMe: false
            confirmButton.enabled: true
            cancelButton.enabled: true
            onFinished: {
                if (result == SystemUiResult.ConfirmButtonSelection) {
                    editTitle(inputFieldTextEntry())
                }
            }
        }
    ]
    actions: [
        ActionItem {
            title: "Edit Title"
            onTriggered: {
                edit.show()
            }
        },
        ActionItem {
            title: "Add Comment"
            ActionBar.placement: ActionBarPlacement.Signature
            imageSource: "asset:///images/BBicons/ic_add.png"
            onTriggered: {
                commentbox.show()
            }
        },
        DeleteActionItem {
            title: "Delete"
            onTriggered: {
                deleteTaskDilog.show()
            }
        }

    ]
    function getComments() {
        var doc = new XMLHttpRequest();
        var url = endpoint + "comments?order=id&target_type=task&target_id=" + activetask.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var ina = JSON.parse(doc.responseText)
                    var info = new Array()
                    for(var i =0; i < ina.length ; i++){
                        if(ina[i].body != null){
                            info.push(ina[i])
                        }
                    } 
                    info.reverse()
                    
                    comments.dataModel.clear()
                    comments.dataModel.append(info)
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("get", url);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function postComments(content) {
        var doc = new XMLHttpRequest();
        var url = endpoint + "comments?&target_type=task&target_id=" + activetask.id
        url += "&body="
        url += content
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 201) {
                    var info = JSON.parse(doc.responseText)
                    comments.dataModel.insert(0, info)
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("post", url);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function editTitle(content) {
        var doc = new XMLHttpRequest();
        var url = endpoint + "tasks/"+ activetask.id + "?name="
        url += content
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    activetask = JSON.parse(doc.responseText)
                    updateTasks()
                    render()
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("put", url);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function deleteTask(){
        var doc = new XMLHttpRequest();
        var url = endpoint + "tasks/"+activetask.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 204) {
                    updateTasks()
                    taskspane.pop()
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("delete", url);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
}