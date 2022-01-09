import QtQuick 2.1
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import org.kde.taskmanager 0.1 as TaskManager
import org.kde.plasma.private.taskmanager 0.1 as TaskManagerApplet
import org.kde.kwindowsystem 1.0 as KWindowSystem

Item {
    id: root

    property string text: "nothing yet"
    property string deskSep: "~"
    property string totSep: "/"

    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    // count the number of window
    function count() {
      let text = ""

      if (plasmoid.configuration.displayFormat === "totalCount") {
        text = taskmanagerAll.count
      } else {
        text = taskmanagerFiltered.count

        if (plasmoid.configuration.showTotal) {
          text += root.totSep + taskmanagerAll.count
        }

        if (plasmoid.configuration.showDesktop) {
          text += root.deskSep + windowSystem.currentDesktop
        }
      }

      root.text = text
    }

    // get the info of KWin
    KWindowSystem.KWindowSystem {
      id: windowSystem

      // refresh the data when the user switch desktop
      onCurrentDesktopChanged: {
        root.count()
      }
    }

    // refresh the data when needed
    TaskManager.TasksModel {
      onDataChanged: {
        root.count()
      }
    }

    // get the info for one virtual desktop
    TaskManager.TasksModel {
      id: taskmanagerFiltered
      filterByVirtualDesktop: true // todo add a config for that
      filterByActivity: true // todo add a config for that

      // get +1 for each window (so 3 konsole give +3)
      // if enabled w/ default value get +1 for each "app" (so 3 konsole give +1)
      groupMode: TaskManager.TasksModel.GroupDisabled // todo add a config for that

      // qstring on wayland or uint >0 in x11
      // todo replace false by something like KWindowSystem.isPlatformX11
      virtualDesktop: false ? windowSystem.currentDesktop.toString() : windowSystem.currentDesktop
    }

    // get the info for all the virtual desktop
    TaskManager.TasksModel {
      id: taskmanagerAll
      filterByVirtualDesktop: false
      filterByActivity: true // todo add a config for that

      // get +1 for each window (so 3 konsole give +3)
      // if enabled w/ default value get +1 for each "app" (so 3 konsole give +1)
      groupMode: TaskManager.TasksModel.GroupDisabled // todo add a config for that
    }

    // ui
    Plasmoid.compactRepresentation: Item {
      id: output
      width: 100

      PlasmaCore.IconItem {
          source: ""
      }

      PlasmaComponents.Label {
        id: label
        text: root.text
        width: parent.width
        height: parent.height
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
      }
    }

}
