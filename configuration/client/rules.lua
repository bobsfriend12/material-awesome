local awful = require('awful')
local gears = require('gears')
local ruled = require('ruled')
local beautiful = require('beautiful')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')

ruled.client.connect_signal(
	'request::rules',
	function()
		-- All clients will match this rule.
		ruled.client.append_rule {
			id = 'global',
			rule = {},
			properties = {
				focus = awful.client.focus.filter,
				raise = true,
				floating = false,
				maximized = false,
				above = false,
				below = false,
				ontop = false,
				sticky = false,
				maximized_horizontal = false,
				maximized_vertical = false,
				keys = client_keys,
				buttons = client_buttons,
				screen = awful.screen.preferred,
				placement = awful.placement.no_overlap + awful.placement.no_offscreen
			}
		}

		ruled.client.append_rule {
			id = 'round_clients',
			rule_any = {
				type = {
					'normal',
					'dialog'
				}
			},
			except_any  = {
				name = {'Discord Updater'}
			},
			properties = {
				round_corners = true,
				shape = beautiful.client_shape_rounded
			}
		}

		-- Titlebar rules
		ruled.client.append_rule {
			id 	= 'titlebars',
			rule_any = {
				type = {
					'normal',
					'dialog',
					'modal',
					'utility'
				}
			},
			properties = {
				titlebars_enabled = false
			}
		}

		-- Dialogs
		ruled.client.append_rule {
			id = 'dialog',
			rule_any = {
				type  = {'dialog'},
				class = {
					'Wicd-client.py',
					'calendar.google.com'
				}
			},
			properties = {
				titlebars_enabled = false,
				floating = true,
				above = true,
				skip_decoration = true,
				placement = awful.placement.centered
			}
		}

		-- Modals
		ruled.client.append_rule {
			id = 'modal',
			rule_any = {
				type = {'modal'}
			},
			properties = {
				titlebars_enabled = false,
				floating = true,
				above = true,
				skip_decoration = true,
				placement = awful.placement.centered
			}
		}

		-- Splash
		ruled.client.append_rule {
			id = 'splash',
			rule_any = {
				type = {'splash'},
				name = {'Discord Updater'}
			},
			properties = {
				titlebars_enabled = false,
				round_corners = false,
				floating = true,
				above = true,
				skip_decoration = true,
				placement = awful.placement.centered
			}
		}

		-- Quake Terminal
		ruled.client.append_rule {
			id = 'terminals',
			rule_any = {
				name = {
					'QuakeTerminal'
				}
			},
			properties = {
				-- Make the window floating
				floating = true,

				-- Make the window stick to ALL tags/workspaces (this is what lets you toggle it on all tags)
				sticky = true
			}
		}

		-- Floating windows
		ruled.client.append_rule {
			id = 'floatingwindows',
			rule_any = {
				class = {
					'scrcpy'
				}
			},
			properties = {
				-- Make the window floating
				floating = true
			}
		}

		-- Example rule for looking-glass (framebuffer relay for gpu passthrough)
		-- This rule will move looking-glass to tag 5 and set that tag as the
		-- active workspace when looking-glass is started
		ruled.client.append_rule {
			id = 'looking-glass',
			rule_any = {
				class = {
					'looking-glass-client'
				}
			},
			properties = {
				tag = '5',
				switch_to_tags = true
			}
		}

		-- Gaming
		ruled.client.append_rule {
			id = 'gaming',
			rule_any = {
				class = {
					'dolphin-emu',
					'Steam',
					'Lutris',
					'Citra',
					'supertuxkart'
				},
				name = {
					'Steam',
					'Lutris'
				}
			},
			properties = {
				tag = '4',
				skip_decoration = true,
				switch_to_tags = true,
				
				-- Place the window in the center if the tag is set to floating mode
				placement = awful.placement.centered
			}
		}

		-- Graphics Editing
		ruled.client.append_rule {
			id = 'graphics',
			rule_any = {
				class = {
					'Gimp',
					'Inkscape',
					'Flowblade'
				}
			},
			properties = {
				tag = '8',
				switch_to_tags = true,
			}
		}
	end
)

-- Normally we'd do this with a rule, but some programs like spotify doesn't set its class or name
-- until after it starts up, so we need to catch that signal.
client.connect_signal(
	'property::class',
	function(c)
		if c.class == 'Spotify' then
			local window_mode = false

			-- Check if fullscreen or window mode
			if c.fullscreen then
				window_mode = false
				c.fullscreen = false
			else
				window_mode = true
			end

			-- Check if Spotify is already open
			local app = function (c)
				return ruled.client.match(c, {class = 'Spotify'})
			end

			local app_count = 0
			for c in awful.client.iterate(app) do
				app_count = app_count + 1
			end

			-- If Spotify is already open, don't open a new instance
			if app_count > 1 then
				c:kill()
				-- Switch to previous instance
				for c in awful.client.iterate(app) do
					c:jump_to(false)
				end
			else
				-- Move the instance to specified tag on this screen
				local t = awful.tag.find_by_name(awful.screen.focused(), '5')
				c:move_to_tag(t)
				t:view_only()

				-- Fullscreen mode if not window mode
				if not window_mode then
					c.fullscreen = true
				else
					c.floating = true
					awful.placement.centered(c, {honor_workarea = true})
				end
			end
		end
	end
)
