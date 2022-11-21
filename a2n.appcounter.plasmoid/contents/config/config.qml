// Copyright (C) 2022  Bouteiller Alan - for more information check the LICENSE file at the root of the project

import QtQuick 2.0

import org.kde.plasma.configuration 2.0

ConfigModel {
    ConfigCategory {
         name: i18n("Appearance")
         icon: "preferences-desktop-color"
         source: "configGeneral.qml"
    }
}
