/*
 * Copyright (c) 2011-2014 BlackBerry Limited.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_
#include "database.hpp"
#include "DownloadManager.hpp"
#include <QObject>

namespace bb
{
    namespace cascades
    {
        class LocaleHandler;
    }
}

class QTranslator;
class Database;
class DownloadManager;
/*!
 * @brief Application UI object
 *
 * Use this object to create and init app UI, to create context objects, to register the new meta types etc.
 */
class ApplicationUI: public QObject
{
Q_OBJECT
public:
    ApplicationUI();
    virtual ~ApplicationUI()
    {
    }

    Q_INVOKABLE void logout();
    Q_INVOKABLE void callMain();
    Q_INVOKABLE QString getToken();
    Q_INVOKABLE QString getRefresh();
    Q_INVOKABLE QString isImageAvailabel(QString);
    Q_INVOKABLE void getImage(QString, QString);
    Q_INVOKABLE void insertSettings(QString, QString);

private slots:
    void onSystemLanguageChanged();

private:
    QTranslator* m_pTranslator;
    bb::cascades::LocaleHandler* m_pLocaleHandler;
    Database* db;
    DownloadManager *DM;
    void Login();
    void Init();

    void mainView();
};

#endif /* ApplicationUI_HPP_ */
