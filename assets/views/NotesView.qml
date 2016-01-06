import bb.cascades 1.3
import bb.system 1.2
import "../titlebar"
Page {
    titleBar: NotesViewTitlebar {

    }
    onCreationCompleted: {
        console.log(JSON.stringify(activenotes))
        watch.text = activenotes['watcher_ids'].length
        name.text  = activenotes.name
        body.text = "<html>" + activenotes.content + "</html>"
    }
    
    ScrollView {

        Container {

            Container {
                topPadding: 40
                leftPadding: 40
                rightPadding: 20
                Label { //Notes name here
                    multiline: true
                    text: "Notes Name"
                    id: name
                }
            }

            Container {
                verticalAlignment: VerticalAlignment.Center
                horizontalAlignment: HorizontalAlignment.Center
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }

                Container {
                    verticalAlignment: VerticalAlignment.Center
                    horizontalAlignment: HorizontalAlignment.Center
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    leftPadding: 40
                    rightPadding: 20
                    bottomPadding: 20
                    Label { // project name here
//                        text: "Project Name"
                        opacity: .5
                        textStyle.fontSize: FontSize.PointValue
                        textStyle.fontSizeValue: 6

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
                                id: watch
                                textFormat: TextFormat.Html
                                multiline: true
                            }
                        }
                    }

                }
            }
            Divider {

            }
            Container {
                leftPadding: 30
                rightPadding: 10
                topPadding: 20
                Label { //Notes body here
                    text: "Notes Body"
                    id : body
                    textFormat: TextFormat.Auto
                    multiline: true
                }
            }

        }
    }
    actions: [
        DeleteActionItem {
            title: "Delete"
            onTriggered: {
                deleteTaskDilog.show()
            }
        },
        ActionItem {
            title: "Edit Title"
            onTriggered: {
                edit.inputFieldTextEntry(activenotes.name)
                edit.show()
            }
        }

    ]
    attachedObjects: [
        SystemDialog {
            id: deleteTaskDilog
            title: qsTr("Delete")
            body: qsTr("Do you want to Delete this item ?")
            confirmButton.enabled: true
            confirmButton.label: qsTr("Yes")
            cancelButton.enabled: true
            onFinished: {
                if (result == SystemUiResult.ConfirmButtonSelection) {
                    deleteNotes()
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
    actionBarVisibility: ChromeVisibility.Compact
    function editTitle(content) {
        var doc = new XMLHttpRequest();
        var url = endpoint + "notes/"+ activenotes.id + "?name="
        url += content
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    updateNotes()
                    var info = JSON.parse(doc.responseText)
                    name.text = content
                    
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
    function deleteNotes(){
        var doc = new XMLHttpRequest();
        var url = endpoint + "notes/"+activenotes.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 204) {
                    notespane.pop()
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