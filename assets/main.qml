import bb.cascades 1.4
import bb.system 1.2
import bb.data 1.0
import bb.device 1.4
import "titlebar"
import "views"
import "items"
import "moment.js" as Moment
TabbedPane {
    signal updateTasks
    signal updateConversation
    signal updateNotes
    property variant log_accounts: []
    property variant me
    property variant orgs
    property variant projects
    property variant tasklists
    property variant tasks
    property variant notesdata
    property variant endpoint: "https://redbooth.com/api/3/"
    property variant token
    property variant people
    property variant activetask
    property variant activeproject
    property variant activeconversation
    property variant activenotes
    property variant ref

    id: tabholder
    Menu.definition: [
        MenuDefinition {
            actions: [
                ActionItem {
                    title: qsTr("About Us")
                    imageSource: "asset:///images/BBicons/ic_info.png"
                    onTriggered: {
                        navigationpane.push(team_info.createObject())
                    }
                },
                ActionItem {
                    title: qsTr("Settings")
                    imageSource: "asset:///images/BBicons/ic_settings.png"
                    onTriggered: {
                        app.logout()
                        Application.requestExit()
                    }
                },
                ActionItem {
                    title: qsTr("Review")
                    imageSource: "asset:///images/BBicons/ic_compose.png"
                    attachedObjects: [
                        Invocation {
                            id: invoke
                            query: InvokeQuery {
                                invokeTargetId: "sys.appworld"
                                uri: "appworld://content/59950357"
                            }
                        }
                    ]
                    onTriggered: {
                        invoke.trigger("bb.action.OPEN")
                    }
                },
                ActionItem {
                    title: qsTr("Help")
                    imageSource: "asset:///images/BBicons/ic_help.png"
                    onTriggered: {
                        help.trigger("bb.action.OPEN")
                    }
                    attachedObjects: [
                        Invocation {
                            id: help
                            query: InvokeQuery {
                                invokeTargetId: "sys.browser"
                                uri: "https://ahamtech.in/banana/help"
                            }
                        }
                    ]
                }

            ]
        }
    ]
    attachedObjects: [
        DeviceInfo {
            id: deviceinfo

        },
        ComponentDefinition {
            id: team_info
            source: "asset:///aboutus.qml"
        },
        SystemDialog {
            confirmButton.label: qsTr("Delete List")
            id: deleteitem
            title: qsTr("Delete Project")
            body: qsTr("Delete Project Permanently ?")
            onFinished: {
                if (result == SystemUiResult.ConfirmButtonSelection) {
                    deleteProject(Qt.touchedItem.url)
                } else {
                    touchedItem = null
                }
            }
        },

        Sheet {
            id: loading
            onOpened: {
                var link = "https://redbooth.com/oauth2/authorize?client_id=fcea02e5139c36f813c95e28eaa38018bce14baab2669b9b80faa5f4f43f7552&redirect_uri=http://localhost&response_type=code"
                webWindow.url = link
            }
            content: Page {
                Container {
                    horizontalAlignment: HorizontalAlignment.Center
                    verticalAlignment: VerticalAlignment.Fill
                    ScrollView {

                        Container {
                            layout: DockLayout {
                            }
                            onCreationCompleted: {
                                webWindow.storage.clear()
                            }
                            WebView {

                                id: webWindow
                                onCreationCompleted: {
                                    storage.clear()
                                    storage.clearCache()
                                    storage.clearCookies()
                                    storage.clearCredentials()
                                }
                                onUrlChanged: {

                                    if (url.toString().indexOf("authorize") > 0 || url.toString().indexOf("approve_access") > 0) {
                                    } else {
                                        if (url.toString().indexOf("localhost") > 0) {
                                            console.log(url.toString())
                                            var items = url.toString().split("?")
                                            var cod = items[1].split("=")
                                            getKey(cod[1])
                                        }
                                    }
                                }

                                onLoadProgressChanged: {
                                    webviewprgoress.value = loadProgress / 100
                                }
                            }

                        }

                    }

                    ProgressIndicator {
                        id: webviewprgoress
                        value: 0.1
                        horizontalAlignment: HorizontalAlignment.Fill
                        verticalAlignment: VerticalAlignment.Bottom
                    }
                }
            }
        },
        Sheet {
            id: refkeys
            content: Page {
                Label {
                    text: "loading Keys"
                }
            }
        },
        SceneCover {
            id: sceneCover
            content: Container {
                Label {
                    id: label
                    textStyle.color: Color.Red
                    multiline: true
                }
            }
        }

    ]
    onCreationCompleted: {
        Qt.getUserNameFromId = getUserNameFromId
        Qt.taskComplete = taskComplete
        Qt.getIdfromUserId = getIdfromUserId
        Qt.app = app
        token = app.getToken()
        if (token) {
            getMe()
        } else {
            loading.open()
        }
    }

    onActiveprojectChanged: {
        projects.description = activeproject.name
        getData()
    }

    function initapp() {
        events()
        getProjects()
    }

    function getData() {
        people = null
        notesdata = null
        notesdata = null
        getPeople()
        getPeoplemeta()
        getTaskList()
        getConversation()
        getNotes()
    }
    onUpdateConversation: {
        getConversation()
    }
    onUpdateNotes: {
        getNotes()
    }
    onUpdateTasks: {
        getTaskList()
    }
    sidebarState: SidebarState.VisibleFull

    Tab {
        id: dashboard
        title: "Dashboard"
        imageSource: "asset:///images/BBicons/ic_add_to_contacts.png"
        NavigationPane {
            id: accounts_navigation
            Page {
                titleBar: DashboardTilebar {

                }
                actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
                actionBarVisibility: ChromeVisibility.Compact
                resizeBehavior: PageResizeBehavior.None
                Container {

                    Container {
                        horizontalAlignment: HorizontalAlignment.Fill
                        background: Color.create("#e6e6e6")

                        verticalAlignment: VerticalAlignment.Fill
                        SegmentedControl {

                            horizontalAlignment: HorizontalAlignment.Fill

                            id: selectChats
                            selectedIndex: 0
                            Option {
                                text: qsTr("Notifications") + Retranslate.onLanguageChanged
                                value: "notification"
                            }
                            Option {
                                text: qsTr("All Activity") + Retranslate.onLanguageChanged
                                value: "activity"
                            }

                            onSelectedIndexChanged: {
                                switch (selectedValue) {
                                    case 'notification':
                                        //                                    classifycontacts()
                                        break;
                                    case 'activity':
                                        //                                    classifycontacts()
                                        break;

                                }
                            }
                        }

                    }
                    ListView {
                        id: notification
                        dataModel: ArrayDataModel {

                        }
                        listItemComponents: [
                            ListItemComponent {
                                type: ""
                                CustomListItem {
                                    DashboardNotificationsItem {
                                        title: ListItemData.title
                                        des: ListItemData.target_type
                                    }
                                }
                            }
                        ]
                    }
                }
            }
        }
    }
    Tab {
        id: projects
        title: "Projects"
        imageSource: "asset:///images/new/projectsicon.png"

        NavigationPane {
            onPopTransitionEnded: {
                page.destroy()
            }

            Page {
                actions: [
                    ActionItem {
                        title: "Create Project"
                        ActionBar.placement: ActionBarPlacement.Signature

                        imageSource: "asset:///images/BBicons/ic_add.png"
                        onTriggered: {
                            project_navigation.push(createProjectPage.createObject())

                        }
                    }

                ]
                titleBar: ProjectListTitlebar {

                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    background: Color.create("#e6e6e6")
                    verticalAlignment: VerticalAlignment.Fill
                    ListView {
                        leadingVisual: PullToRefresh {
                            onRefreshTriggered: {
                                getPeople()
                                getPeoplemeta()
                                getProjects()
                            }
                        }
                        id: projectslistview
                        dataModel: ArrayDataModel {

                        }
                        onTriggered: {
                            select(indexPath)
                            activeproject = dataModel.data(indexPath)
                        }
                        listItemComponents: [
                            ListItemComponent {
                                type: ""
                                CustomListItem {
                                    dividerVisible: false
                                    ProjectListItem {
                                        title: ListItemData.name
                                    }
                                }
                            }
                        ]
                    }
                }

            }
        }
    }
    Tab {
        id: tasks
        title: "Tasks List"
        imageSource: "asset:///images/BBicons/ic_view_list.png"

        NavigationPane {
            id: taskspane
            onPopTransitionEnded: {
                page.destroy()
            }
            attachedObjects: [
                ComponentDefinition {
                    id: taskspage
                    source: "asset:///views/TaskView.qml"
                },
                SystemPrompt {
                    id: newtasklst
                    title: qsTr("New Task List")
                    rememberMeChecked: false
                    includeRememberMe: false
                    confirmButton.enabled: true
                    cancelButton.enabled: true
                    onFinished: {
                        if (result == SystemUiResult.ConfirmButtonSelection) {
                            newtasklist(inputFieldTextEntry())
                        }
                    }
                },
                SystemPrompt {
                    id: newtaskitm
                    title: qsTr("New Task List")
                    rememberMeChecked: false
                    includeRememberMe: false
                    confirmButton.enabled: true
                    cancelButton.enabled: true
                    onFinished: {
                        if (result == SystemUiResult.ConfirmButtonSelection) {
                            newtask(inputFieldTextEntry())
                        }
                    }
                }
            ]
            Page {
                actions: [
                    ActionItem {
                        title: "Create TaskList"
                        onTriggered: {
                            newtasklst.show()
                        }
                    }

                ]
                titleBar: TaskListTitlebar {

                }
                actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
                actionBarVisibility: ChromeVisibility.Overlay
                resizeBehavior: PageResizeBehavior.None
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    background: Color.create("#e6e6e6")
                    verticalAlignment: VerticalAlignment.Fill
                    ListView {
                        id: tasklist
                        dataModel: GroupDataModel {
                            grouping: ItemGrouping.ByFullValue
                            sortingKeys: [ 'title', 'type', 'row_order' ]
                        }
                        function itemType(data, indexPath) {
                            if (indexPath.length > 1 && data.type == "newitem") {
                                return "newitem"
                            } else {
                                if (indexPath.length > 1) {
                                    return "item"
                                } else {
                                    return "header"
                                }
                            }
                        }
                        leadingVisual: PullToRefresh {
                            onRefreshTriggered: {
                                if (ref == true) {

                                } else {
                                    ref = true
                                    getTaskList()
                                }
                            }
                        }
                        onTriggered: {
                            select(indexPath)
                            activetask = dataModel.data(indexPath)
                            taskspane.push(taskspage.createObject())
                        }
                        listItemComponents: [
                            ListItemComponent {
                                type: "header"
                                StandardListItem {
                                    title: ListItemData
                                }

                            },
                            ListItemComponent {
                                type: "item"
                                CustomListItem {
                                    dividerVisible: false
                                    TaskListItem {
                                        title: ListItemData.name
                                        time: ListItemData.due_on
                                        image: if(ListItemData.assigned_id != null){
                                            var a = Qt.getIdfromUserId(ListItemData['assigned_id'])
                                                return Qt.app.isImageAvailabel(a) }
                                        onTaskComplete: {
                                            Qt.taskComplete(ListItemData.id, true)
                                        }
                                        onTaskIncomplete: {
                                            Qt.taskComplete(ListItemData.id, false)
                                        }
                                    }
                                }
                            },
                            ListItemComponent {
                                type: "newitem"
                                StandardListItem {
                                    status: "Create Task"
                                }
                            }
                        ]
                    }
                }
            }
        }
    }
    Tab {
        id: conversations
        title: "Conversations"
        imageSource: "asset:///images/BBicons/ic_bbm.png"

        NavigationPane {
            id: navcon
            onPopTransitionEnded: {
                page.destroy()
            }
            attachedObjects: [
                ComponentDefinition {
                    id: conversationpage
                    source: "asset:///views/ConversationView.qml"

                }
            ]
            Page {
                actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
                actionBarVisibility: ChromeVisibility.Overlay
                resizeBehavior: PageResizeBehavior.None
                actions: [
                    ActionItem {
                        title: "Create Conversation"
                        ActionBar.placement: ActionBarPlacement.Signature

                        imageSource: "asset:///images/BBicons/ic_add.png"
                        onTriggered: {
                            navcon.push(conversationpage.createObject())

                        }
                    }

                ]
                titleBar: ConversationListTitlebar {

                }
                Container {
                    horizontalAlignment: HorizontalAlignment.Fill
                    background: Color.create("#e6e6e6")
                    verticalAlignment: VerticalAlignment.Fill
                    ListView {
                        id: conversationlist
                        leadingVisual: PullToRefresh {
                            onRefreshTriggered: {
                                getConversation()
                            }
                        }
                        dataModel: ArrayDataModel {

                        }
                        onTriggered: {
                            select(indexPath)
                            activeconversation = dataModel.data(indexPath)
                            navcon.push(conversationpage.createObject())
                        }
                        listItemComponents: [
                            ListItemComponent {
                                type: ""
                                CustomListItem {
                                    dividerVisible: false
                                    ConversationListItem {
                                        title: ListItemData.name
                                        user: Qt.getUserNameFromId(ListItemData['user_id'])
                                        time: Moment.moment.unix(ListItemData['created_at']).format("LLLL")
                                        image: Qt.app.isImageAvailabel(ListItemData['user_id'])
                                    }
                                }
                            }
                        ]
                    }
                }

            }
        }
    }
    Tab {
        id: notes
        title: "Notes"
        imageSource: "asset:///images/BBicons/ic_doctype_doc.png"

        NavigationPane {
            id: notespane
            onPopTransitionEnded: {
                page.destroy()
            }
            attachedObjects: [
                ComponentDefinition {
                    id: notespage
                    source: "asset:///views/NotesView.qml"
                }
            ]
            Page {
                actions: [
                    ActionItem {
                        title: "Create Notes"
                        ActionBar.placement: ActionBarPlacement.Signature

                        imageSource: "asset:///images/BBicons/ic_add.png"
                        onTriggered: {
                            project_navigation.push(createProjectPage.createObject())

                        }
                    }

                ]
                titleBar: NotesListTitlebar {

                }

                actionBarAutoHideBehavior: ActionBarAutoHideBehavior.HideOnScroll
                actionBarVisibility: ChromeVisibility.Overlay
                resizeBehavior: PageResizeBehavior.None
                ListView {
                    id: noteslist
                    dataModel: ArrayDataModel {

                    }
                    leadingVisual: PullToRefresh {
                        onRefreshTriggered: {
                            getNotes()
                        }
                    }
                    onTriggered: {
                        select(indexPath)
                        activenotes = dataModel.data(indexPath)
                        notespane.push(notespage.createObject())
                    }
                    listItemComponents: [
                        ListItemComponent {
                            type: ""
                            CustomListItem {
                                dividerVisible: false
                                NotesListItem {
                                    title: ListItemData.name
                                    timer: Moment.moment.unix(ListItemData['updated_at']).format('lll')
                                }
                            }
                        }
                    ]

                }

            }
        }
    }

    function getProjects() {
        var doc = new XMLHttpRequest();
        var url = endpoint + "projects?order=id&archived=false"
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var data = JSON.parse(doc.responseText)
                    projects = data
                    projectslistview.dataModel.clear()
                    projectslistview.dataModel.append(data)
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

    function events() {
        var doc = new XMLHttpRequest();
        var url = endpoint + "activities"
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var events = JSON.parse(doc.responseText)
                    notification.dataModel.clear()
                    notification.dataModel.append(events)

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
    function getPeople() {
        var doc = new XMLHttpRequest();
        var url = endpoint + "users?project_id=" + activeproject.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    people = JSON.parse(doc.responseText)
                    for (var i = 0; i < people.length; i ++) {
                        if (people[i]['avatar_url'].indexOf('amazonaws') > 0) {
                            app.getImage(people[i]['avatar_url'],people[i].id+".png")
                        }
                    }
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
    function getPeoplemeta() {
        var doc = new XMLHttpRequest();
        var url = endpoint + "people?project_id=" + activeproject.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var info = JSON.parse(doc.responseText)
                    var peop = new Array()
                    for (var i = 0; i < info.length; i ++) {
                        for(var j = 0; j < people.length; j ++ ){
                            if(info[i].user_id == people[j].id){
                                people[j].user_id = info[i].user_id
                            }
                        }
                    }
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
    function getKey(code) {
        var doc = new XMLHttpRequest();
        var getkeylink = "https://redbooth.com/oauth2/token/?client_id=fcea02e5139c36f813c95e28eaa38018bce14baab2669b9b80faa5f4f43f7552&client_secret=5297c10ef12aa032477c4e630e4570696b76375e7ccb319d3bc24d86bfd25823&code=" + code + "&grant_type=authorization_code&redirect_uri=http://localhost"
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var info = JSON.parse(doc.responseText)
                    app.insertSettings("token", info['access_token'])
                    app.insertSettings("refresh", info['refresh_token'])
                    app.insertSettings("token_type", info['bearer'])
                    loading.close()
                    getMe()
                } else {
                    console.log(doc.responseText + doc.statusText)
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("POST", getkeylink);
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10/RB Client");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function refreshToken() {
        refkeys.open()
        var doc = new XMLHttpRequest();
        var ref = app.getRefresh()
        var getkeylink = "https://redbooth.com/oauth2/token/?client_id=fcea02e5139c36f813c95e28eaa38018bce14baab2669b9b80faa5f4f43f7552&client_secret=5297c10ef12aa032477c4e630e4570696b76375e7ccb319d3bc24d86bfd25823&refresh_token=" + ref + "&grant_type=refresh_token"
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var info = JSON.parse(doc.responseText)
                    app.insertSettings("token", info['access_token'])
                    app.insertSettings("refresh", info['refresh_token'])
                    app.insertSettings("token_type", info['bearer'])
                    refkeys.close()
                    initapp()
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("POST", getkeylink);
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10/RB Client");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function parseErrorResp(data) {
        switch (data.status) {
            case 401:
                {
                    refreshToken()
                }
        }
        
    }
    function getTaskList() {
        var doc = new XMLHttpRequest();
        var link = endpoint + "task_lists?order=updated_at-DESC&archived=false&project_id=" + activeproject.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    tasklist.dataModel.clear()
                    var info = JSON.parse(doc.responseText)
                    tasklists = info
                    getTasks()
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("get", link);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function getTasks() {
        var doc = new XMLHttpRequest();
        var link = endpoint + "tasks?order=id&project_id=" + activeproject.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    tasklist.dataModel.clear()
                    var info = JSON.parse(doc.responseText)
                    var da = new Array()
                    for (var i = 0; i < info.length; i ++) {
                        for (var j = 0; j < tasklists.length; j ++) {
                            if (info[i]['task_list_id'] == tasklists[j]['id']) {
                                info[i]['title'] = tasklists[j]['name']
                                if (info[i].status != "resolved") {
                                    da.push(info[i])
                                }
                            }
                        }
                    }
                    for (var i = 0; i < tasklists.length; i ++) {
                        var d = {
                        }
                        d.title = tasklists[i].name
                        d.type = "newitem"
                        d.name = "Create Task"
                        da.push(d)
                    }
                    tasks.description = da.length - tasklists.length + " tasks"
                    tasklist.dataModel.insertList(da)
                    ref = false
                } else {
                    parseErrorResp(doc)
                }
            }
        }
        doc.open("get", link);
        doc.setRequestHeader("Authorization", "Bearer " + app.getToken());
        doc.setRequestHeader("Content-Type", "application/json");
        doc.setRequestHeader("User-Agent", "BB10");
        doc.setRequestHeader("Content-Encoding", "UTF-8");
        doc.send();
    }
    function getConversation() {
        var doc = new XMLHttpRequest();
        var url = endpoint + "conversations?order=updated_at-DESC&project_id=" + activeproject.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var info = JSON.parse(doc.responseText)
                    conversationlist.dataModel.clear()
                    conversationlist.dataModel.append(info)
                    conversations.description = conversationlist.dataModel.size() + " Conversations"
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
    function getNotes() {
        var doc = new XMLHttpRequest();
        var url = endpoint + "notes?order=updated_at-DESC&project_id=" + activeproject.id
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var info = JSON.parse(doc.responseText)
                    notesdata = info
                    noteslist.dataModel.clear()
                    noteslist.dataModel.append(info)
                    notes.description = noteslist.dataModel.size() + " Notes"
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

    function getMe() {
        var doc = new XMLHttpRequest();
        var url = endpoint + "me"
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {
                    var info = JSON.parse(doc.responseText)
                    me = info
                    dashboard.description = info.email
                    
                    initapp()
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
    function getUserNameFromId(id) {
        var ida;
        for (var i = 0; i < people.length; i ++) {
            if (id == people[i].id) {
                ida = people[i]['first_name'] + ' ' + people[i]['last_name']
            }
        }
        return ida
    }
    function getIdfromUserId(id){
        console.log("a " + id)
        var ida;
        for (var i = 0; i < people.length; i ++) {
            console.log(id, people[i].user_id)
            if (id == people[i].user_id) {
                console.log(id,JSON.stringify(people[i]))
                ida = people[i].id
            }
        }
        return ida
    }
    function newtasklist(text) {
        var doc = new XMLHttpRequest();
        var url = endpoint + "task_lists?&project_id=" + activeproject.id + "&name=" + text
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 201) {
                    updateTasks()
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
    function newtask(text) {
        var doc = new XMLHttpRequest();
        var url = endpoint + "tasks?&project_id=" + activeproject.id + "&name=" + text + "&task_list_id=" + actlistid
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 201) {
                    updateTasks()
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
    function taskComplete(id, val) {
        var check
        if (val == true) {
            check = "resolved"
        } else {
            check = "new"
        }
        var doc = new XMLHttpRequest();
        var url = endpoint + "tasks/" + id + "/?status=" + check
        doc.onreadystatechange = function() {
            if (doc.readyState === XMLHttpRequest.DONE) {
                if (doc.status == 200) {

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
}
