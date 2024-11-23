local settings = require("config.settings")
local constants = require("constants")
local colors = settings.colors
local app_icons = settings.icons.apps

local spaces = {}

local function getIconForApp(appName)
    return app_icons[appName] or "?"
end

local function updateSpaceIcons(spaceId, workspaceName)
    local icon_strip = ":desktop:"

    sbar.exec(
        constants.aerospace.LIST_APPS:format(workspaceName),
        function(appsOutput)

            for app in appsOutput:gmatch("[^\r\n]+") do
                local appName = app:match("^%s*(.-)%s*$") -- Trim whitespace
                if appName and appName ~= "" then
                    icon_strip = " " .. getIconForApp(appName)
                end
            end

            if spaces[spaceId] then
                spaces[spaceId].item:set(
                    {
                        label = { string = icon_strip, drawing = true }
                    }
                )
            else
                print("Warning: Space ID '" .. spaceId .. "' not found when updating icons.")
            end
        end
    )
end

local function addWorkspaceItem(workspaceName, monitorId, isSelected)
    local spaceId = constants.items.SPACES .. "." .. workspaceName

    if not spaces[spaceId] then
        local space_item =
            sbar.add(
                "item",
                spaceId,
                {
                    icon = {
                        font = { family = settings.fonts.numbers },
                        string = workspaceName,
                        padding_left = 10,
                        padding_right = 2,
                        color = colors.grey,
                        highlight_color = colors.yellow
                    },
                    label = {
                        padding_right = 12,
                        color = colors.grey,
                        highlight_color = colors.yellow,
                        font = settings.fonts.icons(12),
                        y_offset = -1
                    },
                    padding_left = 2,
                    padding_right = 2,
                    background = {
                        color = colors.popup.bg,
                        border_width = 1,
                        height = 24,
                        border_color = colors.bg1,
                        corner_radius = 9
                    },
                    click_script = constants.aerospace.SWITCH_WORKSPACE .. workspaceName,
                    display = monitorId
                }
            )

        -- Create bracket for double border effect
        local space_bracket =
            sbar.add(
                "bracket",
                { spaceId },
                {
                    background = {
                        color = colors.transparent,
                        border_color = colors.transparent,
                        height = 26,
                        border_width = 1,
                        corner_radius = 9
                    }
                }
            )

        -- Subscribe to mouse events for changing workspace
        space_item:subscribe(
            "mouse.clicked",
            function()
                sbar.exec(constants.aerospace.SWITCH_WORKSPACE .. workspaceName)
            end
        )

        -- Store both the item and its bracket in the spaces table
        spaces[spaceId] = { item = space_item, bracket = space_bracket }
    end

    spaces[spaceId].item:set(
        {
            icon = { highlight = isSelected },
            label = { highlight = isSelected }
        }
    )

    spaces[spaceId].bracket:set(
        {
            background = { border_color = isSelected and colors.dirty_white or colors.transparent }
        }
    )

    updateSpaceIcons(spaceId, workspaceName)
end

local function drawSpaces()
    sbar.exec(
        constants.aerospace.LIST_MONITORS,
        function(monitorsOutput)
            -- Cache the focused workspace to avoid multiple `LIST_CURRENT` queries
            sbar.exec(
                constants.aerospace.LIST_CURRENT,
                function(focusedWorkspaceOutput)
                    local focusedWorkspace = focusedWorkspaceOutput:match("[^\r\n]+")

                    -- Iterate through monitors and workspaces
                    for monitorId in monitorsOutput:gmatch("[^\r\n]+") do
                        sbar.exec(
                            constants.aerospace.LIST_WORKSPACES:format(monitorId),
                            function(workspacesOutput)
                                for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
                                    local isSelected = workspaceName == focusedWorkspace
                                    addWorkspaceItem(workspaceName, monitorId, isSelected)
                                end
                            end
                        )
                    end
                end
            )
        end
    )
end

drawSpaces()

local swapWatcher =
    sbar.add(
        "item",
        {
            drawing = false,
            updates = true
        }
    )

local space_window_observer =
    sbar.add(
        "item",
        {
            drawing = false,
            updates = true
        }
    )

space_window_observer:subscribe(
    constants.events.AEROSPACE_WORKSPACE_CHANGED,
    function(env)
        drawSpaces()
    end
)

space_window_observer:subscribe(
    constants.events.FRONT_APP_SWITCHED,
    function()
        drawSpaces()
    end
)

swapWatcher:subscribe(
    constants.events.SWAP_MENU_AND_SPACES,
    function(env)
        local isShowingSpaces = env.isShowingMenu == "off" and true or false
        sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
    end
)
