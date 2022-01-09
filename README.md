# App counter - plasma widget

## Description

Counts the number of open windows.

Convenient for e.g plasma users using a tilling wm but no task manager.

## Installation

Place the source in `~/.local/share/plasma/plasmoids/` or dl via [the KDE store](https://store.kde.org/browse?cat=418&ord=latest)

## Configuration

| Name | Description | Result |
|--|--|--|
| displayFormat | If you want only the total of the open app or the total by virtual desktop | `Y` or `X` |
| showTotal | Only if displayFormat is set to desktop count - add the total of the open app after the total of open app for the current desktop | `X/A` or `X/A~B` |
| showDesktop | Only if displayFormat is set to desktop count - add the id of the current virtual desktop after the total of open app for the current desktop | `X~B` or `X/A~B` |
| filterByActivity | if you want to filter all the stuff by activity | |
| groupingApp | if you want to group or not the app by the application backing them | |

## Todo
 - custom width
 - improve setting display

## Want to participate ?

Do not hesitate to open a mr or an issue.
