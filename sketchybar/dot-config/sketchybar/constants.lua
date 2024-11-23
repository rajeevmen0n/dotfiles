local events <const> = {
  AEROSPACE_WORKSPACE_CHANGED = "aerospace_workspace_changed",
  AEROSPACE_SWITCH = "aerospace_switch",
  SWAP_MENU_AND_SPACES = "swap_menu_and_spaces",
  FRONT_APP_SWITCHED = "front_app_switched",
  UPDATE_WINDOWS = "update_windows",
  SEND_MESSAGE = "send_message",
  HIDE_MESSAGE = "hide_message",
}

local items <const> = {
  SPACES = "workspaces",
  MENU = "menu",
  MENU_TOGGLE = "menu_toggle",
  FRONT_APPS = "front_apps",
  MESSAGE = "message",
  VOLUME = "widgets.volume",
  WIFI = "widgets.wifi",
  BATTERY = "widgets.battery",
  CALENDAR = "widgets.calendar",
}

local aerospace <const> = {
  LIST_ALL = "aerospace list-workspaces --all",
  LIST_CURRENT = "aerospace list-workspaces --focused",
  LIST_MONITORS = "aerospace list-monitors | awk '{print $1}'",
  LIST_WORKSPACES = "aerospace list-workspaces --monitor all",
  LIST_APPS = "aerospace list-windows --workspace %s | awk -F'|' '{gsub(/^ *| *$/, \"\", $2); print $2}'",
  GET_CURRENT_WINDOW = "aerospace list-windows --focused --format %{app-name}",
  LIST_WINDOWS = "aerospace list-windows --workspace focused --format \"id=%{window-id}, name=%{app-name}\"",
  SWITCH_WORKSPACE = "aerospace workspace ",
}

return {
  items = items,
  events = events,
  aerospace = aerospace,
}
