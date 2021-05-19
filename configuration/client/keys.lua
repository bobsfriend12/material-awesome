local awful = require('awful')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
require('awful.autofocus')
local modkey = require('configuration.keys.mod').mod_key
local altkey = require('configuration.keys.mod').alt_key

local client_keys = awful.util.table.join(
	awful.key(
		{modkey},
		'f',
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = 'toggle fullscreen', group = 'client'}
	),
	awful.key(
		{modkey},
		'q',
		function(c)
			c:kill()
		end,
		{description = 'close', group = 'client'}
	),
	awful.key(
		{altkey, 'Control'},
		'd',
		function()
			awful.client.focus.byidx(1)
		end,
		{description = 'focus next by index', group = 'client'}
	),
	awful.key(
		{altkey, 'Control'},
		'a',
		function()
			awful.client.focus.byidx(-1)
		end,
		{description = 'focus previous by index', group = 'client'}
	),
	awful.key(
		{ modkey, 'Shift'  },
		'd',
		function ()
			awful.client.swap.byidx(1)
		end,
		{description = 'swap with next client by index', group = 'client'}
	),
	awful.key(
		{ modkey, 'Shift' },
		'a',
		function ()
			awful.client.swap.byidx(-1)
		end,
		{description = 'swap with next client by index', group = 'client'}
	),
	awful.key(
		{modkey}, 
		'u', 
		awful.client.urgent.jumpto, 
		{description = 'jump to urgent client', group = 'client'}
	),
	awful.key(
		{altkey},
		'Tab',
		function()
			--awful.client.focus.history.previous()
			awful.client.focus.byidx(1)
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = 'Switch windows', group = 'client'}
	),
    awful.key(
        {modkey},
        'n',
        function(c)
            c.minimized = true
        end,
        {description = 'minimize client', group = 'client'}
    ),
	awful.key(
		{ modkey, 'Shift' }, 
		'c', 
		function(c)
			local focused = awful.screen.focused()

			awful.placement.centered(c, {
				honor_workarea = true
			})
		end,
		{description = 'align a client to the center of the focused screen', group = 'client'}
	),
	awful.key(
		{modkey},
		'c',
		function(c)
			c.fullscreen = false
			c.maximized = false
			c.floating = not c.floating
			c:raise()
		end,
		{description = 'toggle floating', group = 'client'}
	),
	awful.key(
		{altkey, 'Control'},
		'Right',
		function()
			awful.client.focus.byidx(1)
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = 'Give focus to next window', group = 'client'}
	),
	awful.key(
		{altkey, 'Control'},
		'Left',
		function()
			awful.client.focus.byidx(-1)
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = 'Give focus to previous window', group = 'client'}
	),
	-- Move client to tag below
	awful.key(
		{modkey, 'Shift'},
		'Down',
		function()
			if client.focus then
				-- get current tag
				local t = client.focus and client.focus.first_tag or nil
				if t == nil then
					return
				end
				-- get next tag (modulo 9 excluding 0 to wrap from 9 to 1)
				local tag = client.focus.screen.tags[(t.name % 9) + 1]
				awful.client.movetotag(tag)
				awful.tag.viewnext()
			end
		end,
		{description = 'Move client to tag below', group = 'client'},
		descr_move
	),
	-- Move client to tag above
	awful.key(
		{modkey, 'Shift'},
		'Up',
		function()
			if client.focus then
				-- get current tag
				local t = client.focus and client.focus.first_tag or nil
				if t == nil then
					return
				end
				-- get previous tag (modulo 9 excluding 0 to wrap from 1 to 9)
				local tag = client.focus.screen.tags[(t.name - 2) % 9 + 1]
				awful.client.movetotag(tag)
				awful.tag.viewprev()
			end
		end,
		{description = 'Move client to tag above', group = 'client'},
		descr_move
	),
	-- Move client tab to the right
	awful.key(
		{ modkey, 'Shift'  },
		'Right',
		function ()
			awful.client.swap.byidx(1)
		end,
		{description = 'swap with next client by index', group = 'client'}
	),
	-- Move client tab to the left
	awful.key(
		{ modkey, 'Shift' },
		'Left',
		function ()
			awful.client.swap.byidx(-1)
		end,
		{description = 'swap with next client by index', group = 'client'}
	),
	-- Screen management
	awful.key(
		{modkey},
		'o',
		function()
			client.focus:move_to_screen()
		end,
		{description = 'Move client to next screen', group = 'client'}
	),
	awful.key(
		{modkey},
		'Up',
		function(c)
			c:relative_move(0, dpi(-10), 0, 0)
		end,
		{description = 'move floating client up by 10 px', group = 'client'}
	),
	awful.key(
		{modkey},
		'Down',
		function(c)
			c:relative_move(0, dpi(10), 0, 0)
		end,
		{description = 'move floating client down by 10 px', group = 'client'}
	),
	awful.key(
		{modkey},
		'Left',
		function(c)
			c:relative_move(dpi(-10), 0, 0, 0)
		end,
		{description = 'move floating client to the left by 10 px', group = 'client'}
	),
	awful.key(
		{modkey},
		'Right',
		function(c)
			c:relative_move(dpi(10), 0, 0, 0)
		end,
		{description = 'move floating client to the right by 10 px', group = 'client'}
	),
	awful.key(
		{modkey, 'Control', 'Shift'},
		'Up',
		function(c)
			c:relative_move(0, dpi(-10), 0, dpi(10))
		end,
		{description = 'increase floating client size vertically by 10 px up', group = 'client'}
	),
	awful.key(
		{modkey, 'Control', 'Shift'},
		'Down',
		function(c)
			c:relative_move(0, 0, 0, dpi(10))
		end,
		{description = 'increase floating client size vertically by 10 px down', group = 'client'}
	),
	awful.key(
		{modkey, 'Control', 'Shift'},
		'Left',
		function(c)
			c:relative_move(dpi(-10), 0, dpi(10), 0)
		end,
		{description = 'increase floating client size horizontally by 10 px left', group = 'client'}
	),
	awful.key(
		{modkey, 'Control', 'Shift'},
		'Right',
		function(c)
			c:relative_move(0, 0, dpi(10), 0)
		end,
		{description = 'increase floating client size horizontally by 10 px right', group = 'client'}
	),
	awful.key(
		{modkey, 'Control'},
		'Up',
		function(c)
			if c.height > 10 then
				c:relative_move(0, 0, 0, dpi(-10))
			end
		end,
		{description = 'decrease floating client size vertically by 10 px up', group = 'client'}
	),
	awful.key(
		{modkey, 'Control'},
		'Down',
		function(c)
			local c_height = c.height
			c:relative_move(0, 0, 0, dpi(-10))
			if c.height ~= c_height and c.height > 10 then
				c:relative_move(0, dpi(10), 0, 0)
			end
		end,
		{description = 'decrease floating client size vertically by 10 px down', group = 'client'}
	),
	awful.key(
		{modkey, 'Control'},
		'Left',
		function(c)
			if c.width > 10 then
				c:relative_move(0, 0, dpi(-10), 0)
			end
		end,
		{description = 'decrease floating client size horizontally by 10 px left', group = 'client'}
	),
	awful.key(
		{modkey, 'Control'},
		'Right',
		function(c)
			local c_width = c.width
			c:relative_move(0, 0, dpi(-10), 0)
			if c.width ~= c_width and c.width > 10 then
				c:relative_move(dpi(10), 0 , 0, 0)
			end
		end,
		{description = 'decrease floating client size horizontally by 10 px right', group = 'client'}
	)
)

return client_keys
