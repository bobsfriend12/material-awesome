local awful = require('awful')
local beautiful = require('beautiful')
-- 
local hotkeys_popup = require('awful.hotkeys_popup').widget
-- local hotkeys_popup = require('awful.hotkeys_popup').widget.new([hide_without_description = true])


local modkey = require('configuration.keys.mod').mod_key
local altkey = require('configuration.keys.mod').alt_key
local apps = require('configuration.apps')
local filesystem = require('gears.filesystem')
local config_dir = filesystem.get_configuration_dir()
local utils_dir = config_dir .. 'utilities/'

-- Key bindings
local global_keys = awful.util.table.join(

	-- Hotkeys
	awful.key(
		{modkey}, 
		'F1', 
		hotkeys_popup.show_help, 
		{description = 'show help', group = 'awesome'}
	),
	awful.key(
		{modkey, 'Control'}, 
		'r', 
		awesome.restart, 
		{description = 'reload awesome', group = 'awesome'}
	),
	
	awful.key(
		{modkey, 'Control'}, 
		'q', 
		awesome.quit, 
		{description = 'quit awesome', group = 'awesome'}
	),
	awful.key(
		{altkey, 'Shift'},
		'l',
		function()
			awful.tag.incmwfact(0.05)
		end,
		{description = 'increase master width factor', group = 'layout'}
	),
	awful.key(
		{altkey, 'Shift'},
		'h',
		function()
			awful.tag.incmwfact(-0.05)
		end,
		{description = 'decrease master width factor', group = 'layout'}
	),
	awful.key(
		{modkey, 'Shift'},
		'h',
		function()
			awful.tag.incnmaster(1, nil, true)
		end,
		{description = 'increase the number of master clients', group = 'layout'}
	),
	awful.key(
		{modkey, 'Shift'},
		'l',
		function()
			awful.tag.incnmaster(-1, nil, true)
		end,
		{description = 'decrease the number of master clients', group = 'layout'}
	),
	awful.key(
		{modkey, 'Control'},
		'h',
		function()
			awful.tag.incncol(1, nil, true)
		end,
		{description = 'increase the number of columns', group = 'layout'}
	),
	awful.key(
		{modkey, 'Control'},
		'l',
		function()
			awful.tag.incncol(-1, nil, true)
		end,
		{description = 'decrease the number of columns', group = 'layout'}
	),
	awful.key(
		{modkey},
		'space',
		function()
			awful.layout.inc(1)
		end,
		{description = 'select next layout', group = 'layout'}
	),
	awful.key(
		{modkey, 'Shift'},
		'space',
		function()
			awful.layout.inc(-1)
		end,
		{description = 'select previous layout', group = 'layout'}
	),
	awful.key(
		{modkey},
		'+',
		function()
			awful.tag.incgap(1)
		end,
		{description = 'increase gap', group = 'layout'}
	),
	awful.key(
		{modkey},
		'-',
		function()
			awful.tag.incgap(-1)
		end,
		{description = 'decrease gap', group = 'layout'}
	),
	awful.key(
		{altkey, 'Control'}, 
		'Up', 
		awful.tag.viewprev, 
		{description = 'view previous tag', group = 'tag'}
	),
	awful.key(
		{altkey, 'Control'}, 
		'Down', 
		awful.tag.viewnext, 
		{description = 'view next tag', group = 'tag'}
	),
	awful.key(
		{modkey}, 
		'Escape', 
		awful.tag.history.restore, 
		{description = 'alternate between current and previous tag', group = 'tag'}
	),
	awful.key({ modkey, 'Control' }, 
		'w',
		function ()
			-- tag_view_nonempty(-1)
			local focused = awful.screen.focused()
			for i = 1, #focused.tags do
				awful.tag.viewidx(-1, focused)
				if #focused.clients > 0 then
					return
				end
			end
		end, 
		{description = 'view previous non-empty tag', group = 'tag'}
	),
	awful.key({ modkey, 'Control' }, 
		's',
		function ()
			-- tag_view_nonempty(1)
			local focused =  awful.screen.focused()
			for i = 1, #focused.tags do
				awful.tag.viewidx(1, focused)
				if #focused.clients > 0 then
					return
				end
			end
		end, 
		{description = 'view next non-empty tag', group = 'tag'}
	),
	awful.key(
		{modkey, altkey}, 
		'1',  
		function() 
			awful.screen.focus_relative(-1) 
		end,
		{ description = 'focus the previous screen', group = 'screen'}
	),
	awful.key(
		{modkey, 'Shift'}, 
		'2', 
		function()
			awful.screen.focus_relative(1)
		end,
		{ description = 'focus the next screen', group = 'screen'}
	),
	awful.key(
		{modkey, 'Control'},
		'n',
		function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal('request::activate')
				c:raise()
			end
		end,
		{description = 'restore minimized', group = 'screen'}
	),
	awful.key(
		{},
		'XF86MonBrightnessUp',
		function()
			awful.spawn(utils_dir .. 'laptop-brightness add 10', false)
			awesome.emit_signal('widget::brightness')
			awesome.emit_signal('module::brightness_osd:show', true)
		end,
		{description = 'increase brightness by 10%', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86MonBrightnessDown',
		function()
			awful.spawn(config_dir .. 'laptop-brightness sub 10', false)
			awesome.emit_signal('widget::brightness')
			awesome.emit_signal('module::brightness_osd:show', true)
		end,
		{description = 'decrease brightness by 10%', group = 'hotkeys'}
	),
	-- ALSA volume control
	awful.key(
		{},
		'XF86AudioRaiseVolume',
		function()
			awful.spawn('amixer -D pulse sset Master 5%+', false)
			awesome.emit_signal('widget::volume')
			awesome.emit_signal('module::volume_osd:show', true)
		end,
		{description = 'increase volume up by 5%', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioLowerVolume',
		function()
			awful.spawn('amixer -D pulse sset Master 5%-', false)
			awesome.emit_signal('widget::volume')
			awesome.emit_signal('module::volume_osd:show', true)
		end,
		{description = 'decrease volume up by 5%', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioMute',
		function()
			awful.spawn('amixer -D pulse set Master 1+ toggle', false)
		end,
		{description = 'toggle mute', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioNext',
		function()
			awful.spawn('playerctl next', false)
		end,
		{description = 'next music', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioPrev',
		function()
			awful.spawn('playerctl previous', false)
		end,
		{description = 'previous music', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86AudioPlay',
		function()
			awful.spawn('playerctl play-pause', false)
		end,
		{description = 'play/pause music', group = 'hotkeys'}

	),
	awful.key(
		{},
		'XF86AudioMicMute',
		function()
			awful.spawn('amixer set Capture toggle', false)
		end,
		{description = 'mute microphone', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86PowerDown',
		function()
			--
		end,
		{description = 'shutdown skynet', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86PowerOff',
		function()
			awesome.emit_signal('module::exit_screen:show')
		end,
		{description = 'toggle exit screen', group = 'hotkeys'}
	),
	awful.key(
		{},
		'XF86Display',
		function()
			awful.spawn.single_instance('arandr', false)
		end,
		{description = 'arandr', group = 'hotkeys'}
	),
	awful.key(
		{modkey, 'Shift'},
		'q',
		function()
			awesome.emit_signal('module::exit_screen:show')
		end,
		{description = 'toggle exit screen', group = 'hotkeys'}
	),
	awful.key(
		{modkey},
		'.',
		function()
			awesome.emit_signal('module::quake_terminal:toggle')
		end,
		{description = 'dropdown application', group = 'launcher'}
	),
    --awful.key(
		--{modkey}, 
		--'m',
		--function()
			--if awful.screen.focused().musicpop then
				--awesome.emit_signal('widget::music', 'keyboard')
			--end
		--end,
		--{description = 'toggle music widget', group = 'launcher'}
	--),
	awful.key(
    	{'Shift'},
    	'Print',
    	function()
    		awful.util.spawn_with_shell(apps.utils.delayed_screenshot)
    	end,
    	{description = 'Wait 10 seconds then mark an area and screenshot it and copy it to the clipboard', group = 'Utility'}
	),
	awful.key(
		{ },
		'Print',
		function()
			awful.util.spawn_with_shell(apps.utils.screenshot)
		end,
		{description = 'Take a screenshot of your active monitor and copy it to clipboard', group = 'Utility'}
	),
	awful.key(
		{'Control'},
		'Print',
		function()
			awful.util.spawn_with_shell(apps.utils.region_screenshot)
		end,
		{description = 'Mark an area and screenshot it to your clipboard', group = 'Utility'}
	),
	awful.key(
		{modkey},
		'Print',
		function()
			awful.util.spawn_with_shell(apps.utils.ss_and_edit_screenshot)
		end,
		{description = 'Mark an area and screenshot it and edit it', group = 'Utility'}
	),
	awful.key(
		{ }, 
		'Print',
		function ()
			awful.spawn.easy_async_with_shell(apps.utils.full_screenshot,function() end)
		end,
		{description = 'fullscreen screenshot', group = 'Utility'}
	),
	--awful.key(
		--{modkey, 'Shift'}, 
		--'s',
		--function ()
			--awful.spawn.easy_async_with_shell(apps.utils.area_screenshot,function() end)
		--end,
		--{description = 'area/selected screenshot', group = 'Utility'}
	--),
	awful.key(
		{modkey},
		'b',
		function()
			awesome.emit_signal('widget::blur:toggle')
		end,
		{description = 'toggle blur effects', group = 'Utility'}
	),
	awful.key(
		{modkey},
		']',
		function()
			awesome.emit_signal('widget::blur:increase')
		end,
		{description = 'increase blur effect by 10%', group = 'Utility'}
	),
	awful.key(
		{modkey},
		'[',
		function()
			awesome.emit_signal('widget::blur:decrease')
		end,
		{description = 'decrease blur effect by 10%', group = 'Utility'}
	),
	awful.key(
		{modkey},
		't',
		function() 
			awesome.emit_signal('widget::blue_light:toggle')
		end,
		{description = 'toggle redshift filter', group = 'Utility'}
	),
	awful.key(
		{ 'Control' }, 
		'Escape', 
		function ()
			if screen.primary.systray then
				if not screen.primary.tray_toggler then
					local systray = screen.primary.systray
					systray.visible = not systray.visible
				else
					awesome.emit_signal('widget::systray:toggle')
				end
			end
		end, 
		{description = 'toggle systray visibility', group = 'Utility'}
	),
	awful.key(
		{modkey},
		'l',
		function()
			awful.spawn(apps.default.lock, false)
		end,
		{description = 'lock the screen', group = 'Utility'}
	),
	awful.key(
		{modkey},
		'e',
		function()
			awful.spawn(apps.utils.emoji_toggle)
		end,
		{description = 'Toggle emoji typing using ibus', group = 'Utility'}
	),
	awful.key(
		{altkey, 'Control'},
		'space',
		function()
			awful.spawn('vm-attach attach')
		end,
		{description = 'Connect kb and mouse to VM', group = 'Utility'}
	),
	awful.key(
		{modkey}, 
		'Return',
		function()
			awful.spawn(apps.default.terminal)
		end,
		{description = 'open default terminal', group = 'launcher'}
	),
	awful.key(
		{modkey}, 
		'x',
		function()
			awful.spawn(apps.default.terminal)
		end,
		{description = 'open default terminal', group = 'launcher'}
	),
	awful.key(
		{modkey, 'Shift'}, 
		'e',
		function()
			awful.spawn(apps.default.file_manager)
		end,
		{description = 'open default file manager', group = 'launcher'}
	),
	awful.key(
		{modkey, 'Shift'}, 
		'f',
		function()
			awful.spawn(apps.default.web_browser)
		end,
		{description = 'open default web browser', group = 'launcher'}
	),
	awful.key(
		{'Control', 'Shift'}, 
		'Escape',
		function()
			awful.spawn(apps.default.terminal .. ' ' .. 'htop')
		end,
		{description = 'open system monitor', group = 'launcher'}
	),
	awful.key(
		{altkey}, 
		'space',
		function()
			local focused = awful.screen.focused()

			if focused.left_panel then
				focused.left_panel:hide_dashboard()
				focused.left_panel.opened = false
			end
			if focused.right_panel then
				focused.right_panel:hide_dashboard()
				focused.right_panel.opened = false
			end
			awful.spawn(apps.default.rofi_appmenu, false)
		end,
		{description = 'open application drawer', group = 'launcher'}
	),
	awful.key(
		{}, 
		'XF86Launch1',
		function()
			local focused = awful.screen.focused()

			if focused.left_panel then
				focused.left_panel:hide_dashboard()
				focused.left_panel.opened = false
			end
			if focused.right_panel then
				focused.right_panel:hide_dashboard()
				focused.right_panel.opened = false
			end
			awful.spawn(apps.default.rofi_appmenu, false)
		end,
		{description = 'open application drawer', group = 'launcher'}
	),
	awful.key(
		{modkey},
		'r',
		function()
			local focused = awful.screen.focused()

			if focused.right_panel and focused.right_panel.visible then
				focused.right_panel.visible = false
			end
			screen.primary.left_panel:toggle()
		end,
		{description = 'open sidebar', group = 'launcher'}
	),
	awful.key(
		{modkey, 'Shift'},
		'r',
		function()
			local focused = awful.screen.focused()

			if focused.right_panel and focused.right_panel.visible then
				focused.right_panel.visible = false
			end
			screen.primary.left_panel:toggle(true)
		end,
		{description = 'open sidebar and global search', group = 'launcher'}
	),
	awful.key(
		{modkey}, 
		'F2',
		function()
			local focused = awful.screen.focused()

			if focused.left_panel and focused.left_panel.opened then
				focused.left_panel:toggle()
			end

			if focused.right_panel then
				if _G.right_panel_mode == 'today_mode' or not focused.right_panel.visible then
					focused.right_panel:toggle()
					switch_rdb_pane('today_mode')
				else
					switch_rdb_pane('today_mode')
				end

				_G.right_panel_mode = 'today_mode'
			end
		end,
		{description = 'open today pane', group = 'launcher'}
	),
	awful.key(
		{modkey}, 
		'F3',
		function()
			local focused = awful.screen.focused()

			if focused.left_panel and focused.left_panel.opened then
				focused.left_panel:toggle()
			end

			if focused.right_panel then
				if _G.right_panel_mode == 'notif_mode' or not focused.right_panel.visible then
					focused.right_panel:toggle()
					switch_rdb_pane('notif_mode')
				else
					switch_rdb_pane('notif_mode')
				end

				_G.right_panel_mode = 'notif_mode'
			end
		end,
		{description = 'open notification center', group = 'launcher'}
	),
		
	
	
		---------------------------------
		-- My custom keybindings
		
		-- Music player button
		awful.key(
		{}, 
		'XF86Tools',
		function()
			awful.spawn(apps.default.music)
		end,
		{description = 'open default music app', group = 'launcher'}
		),
		-- Open calculator (in the today menu)
		awful.key(
		{}, 
		'XF86Calculator',
		function()
			local focused = awful.screen.focused()

			if focused.left_panel and focused.left_panel.opened then
				focused.left_panel:toggle()
			end

			if focused.right_panel then
				if _G.right_panel_mode == 'today_mode' or not focused.right_panel.visible then
					focused.right_panel:toggle()
					switch_rdb_pane('today_mode')
				else
					switch_rdb_pane('today_mode')
				end

				_G.right_panel_mode = 'today_mode'
			end
		end,
		{description = 'open calculator', group = 'launcher'}
	),

	-- Open rofi with the search key
	awful.key(
		{}, 
		'XF86Search',
		function()
			local focused = awful.screen.focused()

			if focused.left_panel then
				focused.left_panel:hide_dashboard()
				focused.left_panel.opened = false
			end
			if focused.right_panel then
				focused.right_panel:hide_dashboard()
				focused.right_panel.opened = false
			end
			awful.spawn(apps.default.rofi_appmenu, false)
		end,
		{description = 'open application drawer', group = 'launcher'}
	),

	-- Open Defualt Mail App
	awful.key(
		{}, 
		'XF86Mail',
		function()
			awful.spawn(apps.default.mail)
		end,
		{description = 'open default mail app', group = 'launcher'}
		),

	-- Open Defualt 'home' app
	awful.key(
		{}, 
		'XF86HomePage',
		function()
			awful.spawn(apps.default.home)
		end,
		{description = 'open default home app', group = 'launcher'}
		)
	)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	-- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
	local descr_view, descr_toggle, descr_move, descr_toggle_focus
	if i == 1 or i == 9 then
		descr_view = {description = 'view tag #', group = 'tag'}
		descr_toggle = {description = 'toggle tag #', group = 'tag'}
		descr_move = {description = 'move focused client to tag #', group = 'tag'}
		descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
	end
	global_keys =
		awful.util.table.join(
		global_keys,
		-- View tag only.
		awful.key(
			{modkey},
			'#' .. i + 9,
			function()
				local focused = awful.screen.focused()
				local tag = focused.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			descr_view
		),
		-- Toggle tag display.
		awful.key(
			{modkey, 'Control'},
			'#' .. i + 9,
			function()
				local focused = awful.screen.focused()
				local tag = focused.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			descr_toggle
		),
		-- Move client to tag.
		awful.key(
			{modkey, 'Shift'},
			'#' .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
						tag:view_only()
					end
				end
			end,
			descr_move
		),
		-- Toggle tag on focused client.
		awful.key(
			{modkey, 'Control', 'Shift'},
			'#' .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			descr_toggle_focus
		)
	)
end

return global_keys
