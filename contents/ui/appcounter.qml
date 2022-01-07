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
      console.debug(taskmanagerFiltered.count)
      root.text = taskmanagerFiltered.count.toString()
                  + root.totSep
                  + taskmanagerAll.count.toString()
                  + root.deskSep
                  + windowSystem.currentDesktop.toString()
    }

    // get the info of KWin
    KWindowSystem.KWindowSystem {
      id: windowSystem
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

      // refresh the data
      onDataChanged: {
        root.count()
      }
    }

    // get the info for all the virtual desktop
    TaskManager.TasksModel {
      id: taskmanagerAll
      filterByVirtualDesktop: false
      filterByActivity: true // todo add a config for that

      // get +1 for each window (so 3 konsole give +3)
      // if enabled w/ default value get +1 for each "app" (so 3 konsole give +1)
      groupMode: TaskManager.TasksModel.GroupDisabled // todo add a config for that

      // refresh the data
      onDataChanged: {
        root.count()
      }
    }

    Plasmoid.compactRepresentation: Item {
      id: output

      width: 50

      PlasmaCore.IconItem {
          source: ""
      }

      PlasmaComponents.Label {
        id: label
        text: root.text
        wrapMode: Text.Wrap
        width: parent.width
        height: parent.height
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
      }
    }

}
